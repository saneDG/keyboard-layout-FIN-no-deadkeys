# keyboard-layout-FIN-no-deadkeys

A modified Finnish/Nordic macOS keyboard layout with easier access to backticks, tildes, and other programming characters—without dead keys.

#### How the layout differs from default Mac Finnish layout?

- ` (backtick) works with a single keypress, without Shift or dead-key behavior.
- ´ (acute accent) has been moved behind Shift and is no longer a dead key. In effect, ` and ´ have swapped positions.
- ~ (tilde) works with a single keypress, without Option or dead-key behavior.
- ¨ (diaeresis) has been moved behind Option.
- ^ (caret) still requires Shift but is no longer a dead key.
- All other keys and standard Finnish keyboard behavior remain unchanged.

#### Installation

 1. Download the repository as a ZIP and extract it, or clone the repository:

    ```bash
      git clone https://github.com/saneDG/keyboard-layout-FIN-no-deadkeys.git
    ```

 2. Run the installer from the repository directory:

    ```bash
      ./install.sh
    ```

    The installer validates and copies the bundle to `/Library/Keyboard Layouts/`, registers it with macOS, selects it, and verifies that macOS can find it.

> [!IMPORTANT]
> Do not place the bundle in `~/Library/Keyboard Layouts/`. The installer uses the system-wide `/Library/Keyboard Layouts/` directory.

 3. If the installer asks you to log out, log out of macOS and back in once.

 4. If needed, open System Settings → Keyboard → Text Input → Edit and select FIN No Deadkeys.
