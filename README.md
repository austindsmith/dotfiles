# zsh

Plugin manager: [antidote](https://antidote.sh/)

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
