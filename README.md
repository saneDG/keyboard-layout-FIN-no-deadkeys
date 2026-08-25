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
      git clone git@github.com:saneDG/keyboard-layout-FIN-no-deadkeys.git
    ```

 2. Copy FIN No Deadkeys.bundle to the system-wide Keyboard Layouts folder:

    ```text
      /Library/Keyboard Layouts/
    ```

    Using Terminal:

    ```bash
      sudo cp -R "FIN No Deadkeys.bundle" "/Library/Keyboard Layouts/"
    ```

> [!IMPORTANT]
> Do not place the bundle it in user home directory `~/Library/Keyboard Layouts/` or `/Users/your-username/Library/Keyboard Layouts/`.
> Use exact system-wide `/Library/Keyboard Layouts/` path, without `~`!

 4. Log out of macOS and log back in.

 5. Open:

    System Settings → Keyboard → Text Input → Edit

 6. Click +, find FIN No Deadkeys, and add it.

 7. Select FIN No Deadkeys from the input menu in the macOS menu bar.
