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

    Do not place it in ~/Library/Keyboard Layouts/.

    Using Terminal:

    ```bash
      sudo cp -R "FIN No Deadkeys.bundle" "/Library/Keyboard Layouts/"
    ```

 3. Log out of macOS and log back in.

 4. Open:

    System Settings → Keyboard → Text Input → Edit

 5. Click +, find FIN No Deadkeys, and add it.

 6. Select FIN No Deadkeys from the input menu in the macOS menu bar.
