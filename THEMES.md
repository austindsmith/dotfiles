# Theming System

Single-source-of-truth desktop theming via chezmoi templates. Palettes live as
data, app configs are rendered from templates, and the active theme is a
machine-local variable. Switching themes rewrites every themed config in one
`chezmoi apply`.

Origin: the palette is "Polycarbonate Ayu Dark" (a Zed theme by Sha1rholder),
converted to generic semantic names for shell/desktop use.

## Architecture

```
.chezmoidata/themes/*.yaml        palettes (data, one file per theme)
~/.config/chezmoi/chezmoi.toml    theme_active (machine-local state)
*.tmpl files                      consumers (render palette -> app config)
theme-switch                      flips theme_active, re-applies
run_onchange_ script              reloads running apps after a switch
```

Data flows one direction: palette YAML -> chezmoi template engine -> rendered
configs. No app config is ever edited by hand for colors.

## File layout (chezmoi source dir)

```
.chezmoi.toml.tmpl
.chezmoidata/
  themes/
    polycarbonate-ayu.yaml
    <more-themes>.yaml
dot_config/
  quickshell/config/Theme.qml.tmpl
  hypr/theme.conf.tmpl
dot_local/bin/executable_theme-switch
run_onchange_after_theme-reload.sh.tmpl
```

## Palette data format

One file per theme in `.chezmoidata/themes/`. All files merge into a single
`themes` map, so each file declares only its own theme under the shared
top-level key:

```yaml
themes:
  polycarbonate-ayu:
    colors:
      blue: "5ac1fe"
      cyan: "39bae5"
      aqua: "95e5cb"
      green: "aad84c"
      mint: "77dd77"
      gold: "feb454"
      goldAlt: "ffb353"
      orange: "fe8f40"
      sand: "e5b572"
      peach: "f29668"
      red: "ef7177"
      purple: "d2a6fe"
      bronze: "997700"
      text: "bfbdb6"
      textMuted: "a6a5a0"
      textDim: "8c8b88"
      sage: "628b80"
      slate: "5a728b"
      steel: "5577aa"
      gray: "555555"
      charcoal: "333333"
      black: "000000"
    font:
      family: "JetBrainsMono Nerd Font"
      size: 14
```

Rules:

- Colors are bare `RRGGBB`. No `#`, no alpha. Every consumer wants a
  different notation (QML `#AARRGGBB`, Hyprland `rgba(RRGGBBAA)`, kitty
  `#RRGGBB`), so alpha and prefix are applied at the template site.
- Every theme must define the same key names. Templates reference semantic
  keys only; any palette that fills the contract works everywhere.
- Merge order across files is alphabetical; conflicting scalars resolve to
  the later file. Not an issue as long as each file only defines its own
  theme name.
- The `themes/` directory name is organizational only. Namespacing comes
  from the `themes:` key inside each YAML, not the folder.

## Machine-local state

`.chezmoi.toml.tmpl`:

```toml
encryption = "age"

[age]
identity = "{{ .chezmoi.homeDir }}/.config/sops/age/keys.txt"
recipients = [
    "age1702zeej6q48plcgchfy9l68p9jegsryj3h6029rpr2t7t6resc3sa97acd",
    "age19azmnl8ee2f4r95jnwvr47uhllf33eq66dfc3vuxezq7k5vwqgfsyrdv8n",
    "age1yubikey1qvep9uz5xzds4azvlrf5vatl5gmfj48qr8huw5009quwffzvwv80c9avq5j"
]

[sudo]
command = "sudo"

[data]
theme_active = {{ promptStringOnce . "theme_active" "active theme" "polycarbonate-ayu" | quote }}

[data.device]
name = {{ promptStringOnce . "device.name" "device" | quote }}
```

Why here and not `.chezmoidata`: chezmoidata is repo data shared by all
machines. The generated `chezmoi.toml` is per-machine, so each box can run a
different theme off the same repo, and switching does not require a commit.

`promptStringOnce` prompts on first `chezmoi init` and silently reuses the
existing value afterward, including values edited by `theme-switch`.

## Consumer templates

Every template starts with the resolver line, then references `$t`:

```
{{- $t := index .themes .theme_active -}}
```

### Quickshell: `dot_config/quickshell/config/Theme.qml.tmpl`

```qml
{{- $t := index .themes .theme_active -}}
pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: root

    readonly property int fontSizeNormal: {{ $t.font.size }}
    readonly property string fontFamily: "{{ $t.font.family }}"
    readonly property real backgroundOpacity: 0.8
{{- range $name, $hex := $t.colors }}
    readonly property color {{ $name }}: "#{{ $hex }}"
{{- end }}
    readonly property color transparent: "#00000000"
    readonly property color background: "#dd{{ $t.colors.black }}"
    readonly property color surface: "#19ffffff"
    readonly property color surfaceStrong: "#33ffffff"
    readonly property color surfaceHover: "#44ffffff"
    readonly property color shadow: "#11000000"
    readonly property color selection: "#8866aadd"
    readonly property color accent: blue
    readonly property color accentWarm: orange
    readonly property color highlight: bronze
    readonly property color muted: gray
    readonly property var accents: [blue, cyan, orange, purple, aqua, red, gold, green]

    function withAlpha(c, a) {
        return Qt.alpha(c, a)
    }
}
```

QML alpha notation is `#AARRGGBB` (alpha first).

### Hyprland: `dot_config/hypr/theme.conf.tmpl`

```
{{- $t := index .themes .theme_active -}}
general {
    col.active_border = rgba({{ $t.colors.blue }}ee) rgba({{ $t.colors.purple }}ee) 45deg
    col.inactive_border = rgba({{ $t.colors.charcoal }}aa)
}

decoration {
    shadow {
        color = rgba({{ $t.colors.black }}99)
    }
}

group {
    col.border_active = rgba({{ $t.colors.orange }}ee)
    col.border_inactive = rgba({{ $t.colors.slate }}aa)
}
```

Hyprland alpha notation is `rgba(RRGGBBAA)` (alpha last). Wire it in with
`source = ~/.config/hypr/theme.conf` in hyprland.conf.

Adding a new consumer (kitty, fish, btop, rofi, mako, Zed) is always the
same: rename the config to `.tmpl`, add the resolver line, substitute hexes.

## The switch script

`dot_local/bin/executable_theme-switch`:

```bash
#!/usr/bin/env bash
set -euo pipefail

cfg="$HOME/.config/chezmoi/chezmoi.toml"
choice="${1:-}"

if [[ -z "$choice" ]]; then
    choice=$(chezmoi data | jq -r '.themes | keys[]' | fzf --prompt="theme> ")
fi

chezmoi data | jq -e --arg t "$choice" '.themes | has($t)' > /dev/null

sed -i "s/^theme_active = .*/theme_active = \"$choice\"/" "$cfg"
chezmoi apply
```

Bare invocation opens an fzf picker over the palette map; with an argument it
validates and switches directly. Dependencies: jq, fzf.

## Live reload

`run_onchange_after_theme-reload.sh.tmpl`:

```bash
#!/bin/bash
{{- $t := index .themes .theme_active }}
# theme: {{ .theme_active }} {{ include ".chezmoidata/themes/polycarbonate-ayu.yaml" | sha256sum }}
hyprctl reload
pkill -USR1 kitty || true
```

`run_onchange_` scripts re-execute when their rendered content changes. The
comment line embeds the active theme name and a hash of the palette data, so
the script fires exactly when a switch happens or a palette is edited.
Quickshell needs no entry here: it hot-reloads Theme.qml on write.

Add one `include`/`sha256sum` per theme file you want to trigger on, or hash
a concatenation. Add reload commands per app as consumers grow
(`makoctl reload`, gsettings for icon themes, etc.).

## Workflows

Switch theme:

```bash
theme-switch                  # picker
theme-switch gruvbox-glass    # direct
```

Add a theme: drop `<name>.yaml` in `.chezmoidata/themes/` with the full key
contract. It appears in the picker immediately; nothing else changes.

Add a themed app: rename config to `.tmpl`, add resolver, substitute colors,
optionally add a reload line to the run_onchange script.

Preview before applying:

```bash
chezmoi diff
chezmoi execute-template < $(chezmoi source-path)/path/to/file.tmpl
```

Inspect merged data:

```bash
chezmoi data | jq '.themes | keys'
chezmoi data | jq '.theme_active'
```

## Color reference (polycarbonate-ayu)

| name      | hex    | role                         |
| --------- | ------ | ---------------------------- |
| blue      | 5ac1fe | primary accent               |
| cyan      | 39bae5 | secondary cool accent        |
| aqua      | 95e5cb | tertiary cool accent         |
| green     | aad84c | success-ish, links           |
| mint      | 77dd77 | soft green                   |
| gold      | feb454 | warm highlight               |
| goldAlt   | ffb353 | warm highlight variant       |
| orange    | fe8f40 | warm accent                  |
| sand      | e5b572 | muted warm                   |
| peach     | f29668 | soft warm                    |
| red       | ef7177 | errors, urgent               |
| purple    | d2a6fe | special states (scratchpads) |
| bronze    | 997700 | dividers, dark highlight     |
| text      | bfbdb6 | primary foreground           |
| textMuted | a6a5a0 | secondary foreground         |
| textDim   | 8c8b88 | tertiary foreground          |
| sage      | 628b80 | desaturated teal-gray        |
| slate     | 5a728b | inactive cool                |
| steel     | 5577aa | occupied-but-inactive cool   |
| gray      | 555555 | disabled                     |
| charcoal  | 333333 | dark surface                 |
| black     | 000000 | base                         |

Standard alpha suffixes used at template sites: `ee` for borders, `dd` for
glass backgrounds over black, `aa` for inactive, `99` for shadows, `3d` for
selection tints, `19`/`33`/`44` for white overlays.

## Troubleshooting

- `chezmoi data` errors or lacks keys: check `~/.config/chezmoi/` for a
  stale `chezmoi.yaml` alongside `chezmoi.toml`; only one may exist. Rerun
  `chezmoi init` after editing `.chezmoi.toml.tmpl`; the template does
  nothing until init regenerates the config.
- Template error `map has no entry for key`: a palette file is missing a key
  from the contract, or `theme_active` names a theme that does not exist.
  `theme-switch` validates; hand-edits to chezmoi.toml do not.
- Theme did not visibly change: the run_onchange script hash line probably
  does not cover the file you edited, so reloads never fired. Configs still
  updated; restart the app manually and fix the hash line.
- Duplicate TOML section (`[data.device]` twice) hard-fails init. Sections
  may appear once.
- QML color looks wrong: check alpha byte position. QML is alpha-first,
  Hyprland and CSS are alpha-last.
