#!/bin/bash

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
readonly BUNDLE_NAME="FIN No Deadkeys.bundle"
readonly SOURCE_BUNDLE="$SCRIPT_DIR/$BUNDLE_NAME"
readonly INSTALL_DIR="/Library/Keyboard Layouts"
readonly INSTALLED_BUNDLE="$INSTALL_DIR/$BUNDLE_NAME"
readonly INPUT_SOURCE_ID="org.sil.ukelele.keyboardlayout.finnodeadkeys.finnodeadkeys"

if [[ ! -d "$SOURCE_BUNDLE" ]]; then
    echo "Error: $BUNDLE_NAME was not found next to install.sh." >&2
    exit 1
fi

if find "$SOURCE_BUNDLE" -type l -print -quit | grep -q .; then
    echo "Error: the source bundle contains a symbolic link; refusing to install it as root." >&2
    exit 1
fi

plutil -lint "$SOURCE_BUNDLE/Contents/Info.plist" >/dev/null
plutil -lint "$SOURCE_BUNDLE/Contents/version.plist" >/dev/null

bundle_id="$(plutil -extract CFBundleIdentifier raw "$SOURCE_BUNDLE/Contents/Info.plist")"
if [[ "$bundle_id" != "org.sil.ukelele.keyboardlayout.finnodeadkeys" ]]; then
    echo "Error: unexpected bundle identifier: $bundle_id" >&2
    exit 1
fi

echo "Installing $BUNDLE_NAME…"
sudo mkdir -p "$INSTALL_DIR"
sudo rm -rf "$INSTALLED_BUNDLE"
sudo cp -R "$SOURCE_BUNDLE" "$INSTALL_DIR/"
sudo chown -R root:wheel "$INSTALLED_BUNDLE"
sudo chmod -R u+rwX,go+rX "$INSTALLED_BUNDLE"
sudo xattr -cr "$INSTALLED_BUNDLE" 2>/dev/null || true

swift_file="$(mktemp -t fin-no-deadkeys).swift"
trap 'rm -f "$swift_file"' EXIT

cat >"$swift_file" <<'SWIFT'
import Carbon
import Foundation

let bundlePath = CommandLine.arguments[1]
let expectedID = CommandLine.arguments[2]
let bundleURL = URL(fileURLWithPath: bundlePath) as CFURL

let registrationStatus = TISRegisterInputSource(bundleURL)
if registrationStatus != noErr {
    fputs("Could not register the keyboard layout (status \(registrationStatus)).\n", stderr)
    exit(2)
}

let sources = TISCreateInputSourceList(nil, true).takeRetainedValue() as! [TISInputSource]
var matchingSource: TISInputSource?

for source in sources {
    guard let pointer = TISGetInputSourceProperty(source, kTISPropertyInputSourceID) else {
        continue
    }
    let value = Unmanaged<CFTypeRef>.fromOpaque(pointer).takeUnretainedValue()
    if "\(value)" == expectedID {
        matchingSource = source
        break
    }
}

guard let source = matchingSource else {
    fputs("macOS installed the bundle but did not enumerate its input source. Log out and back in, then run install.sh again.\n", stderr)
    exit(3)
}

let enableStatus = TISEnableInputSource(source)
if enableStatus != noErr {
    fputs("Could not enable the keyboard layout (status \(enableStatus)).\n", stderr)
    exit(4)
}

let selectStatus = TISSelectInputSource(source)
if selectStatus != noErr {
    fputs("Could not select the keyboard layout (status \(selectStatus)).\n", stderr)
    exit(5)
}

print("Registered, enabled, and selected \(expectedID)")
SWIFT

swift "$swift_file" "$INSTALLED_BUNDLE" "$INPUT_SOURCE_ID"

# Replace the obsolete identifier used by earlier releases. This also avoids
# application-specific fallback when macOS restores a remembered input source.
defaults write -g AppleCurrentKeyboardLayoutInputSourceID -string "$INPUT_SOURCE_ID"

killall TextInputMenuAgent 2>/dev/null || true
killall TextInputSwitcher 2>/dev/null || true

echo
echo "FIN No Deadkeys is installed and selected."
echo "If it is not visible immediately, log out and back in once."
