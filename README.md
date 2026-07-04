## Windows ideas

- GlazeWM
- YASB
- YASB Quick Launch
- Wezterm/Windows Terminal
- Yazi
- Ditto
- AutoHotkey

## Icons

Candy icons

```zsh
rm -rf ~/.local/share/icons/candy-icons
cd /tmp
git clone https://github.com/EliverLara/candy-icons.git
cp -r candy-icons ~/.local/share/icons/
```

## zsh

Plugin manager: [antidote](https://antidote.sh/)

## Tuis

- Lazygit
- Lazydocker
- k9s
- terraform-tui (tf-tui)
- harlequin
- regex-tui
- yazi
- btop
- ansible-navigator

## tmux

- dmux (session manager)

## Ideas

- Make a full cli for `cbox` from .zshrc and add to Github/AUR
  - Allow configuration via a config file
  - Options for boxes made with `/` or `#` and any other multiline comment types
  - Configurable `padding`, `design`, `text` and levels `-L2` for heading level
  - Add clipboard integration feature with `kitty` and other terminal emulators (unless there's a universal way to do it)
  - Help commands

## Considerations

- Using direnv for environment variables

## Notes

- `if fi` statements prevent zsh from erroring if the corresponding package is not installed on the machine

## Misc Terminal Applications

ripgrep - Search fast

```zsh
rg
```

procs - See processes

```zsh
procs
```

bat - View files

```zsh
bat
```

dust - Disk size

```zsh
dust
```
