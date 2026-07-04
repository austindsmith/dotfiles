# Nvim

Based off of [Kickstart](https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua)

## Remappings

| Key      | Description                  | Location         |
| :--      | :--                          | :--              |
| Capslock | `esc` on tap, `CTRL` on hold | Mapped in Kanata |

---

## Hotkeys

| Keys        | Command              |
| :---------- | :------------------- |
| Space       | Leader               |
| \           | Open file browser    |
| Leader sf   | Search files         |
| Leader sk   | Search keybindings   |
| Leader f    | Format buffer        |

---

## Useful commands

| Keys       | Command                 |
| :--------- | :---------------------- |
| CTRL b     | Back a word             |
| CTRL h,k   | Switch windows          |
| jk         | Switch to normal mode   |
| Leader t   | Open terminal           |
| CTRL y     | Accept auto complete    |


Try out `magma` for Python jupyter notebooks.

______________________________________________________________________

## Extensions

| Name               | Utility                                                |
| :--                | :--                                                    |
| Auto pairs         | Automatically add closing to things like `{`           |
| Auto session       | Restore nvim session on close/re-open                  |
| Bufferline         | Tabs showing buffers                                   |
| Comfy line numbers | Relative line numbers using only left hand             |
| Conform            | Auto-formatting                                        |
| Debug              | In-line error lens                                     |
| Gitsigns           | Git file status in neo-tree                            |
| Harpoon            | Jump between buffers with hotkeys                      |
| Indent line        | Auto-indents                                           |
| Lint               | Auto-formatting                                        |
| Mason              | Syntax highlighting and linting language manager       |
| mini.surround      | ```Allows adding characters to surround a word. `sa"`. |
| Neo-tree           | Shows files in left pane (to adjust to neovim)         |
| Render markdown    | Shows markdown preview in file                         |
| Table mode         | Auto format markdown tables                            |
| Toggle term        | Toggles terminal in neovim with `CTRL t` (`<C-t>`)     |


## Vim motions

| Keys  | Action                                                 |
| :--   | :--                                                    |
| `ciw` | Select a word and delete it, finish in **Insert mode** |
| `gv`  | Re-select last selection                               |
| `x`   | Cut                                                    |
