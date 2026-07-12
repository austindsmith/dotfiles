pragma Singleton
import QtQuick
import Quickshell

QtObject {

    readonly property int fontSizeNormal: 14
    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property real backgroundOpacity: 0.8

    readonly property color transparent: "#00000000"
    readonly property color black: "#000000"

    readonly property color blue: "#5ac1fe"
    readonly property color blueAlt: "#59c2ff"
    readonly property color cyan: "#39bae5"
    readonly property color aqua: "#95e5cb"
    readonly property color aquaAlt: "#95e6cb"
    readonly property color green: "#aad84c"
    readonly property color greenAlt: "#a9d94b"
    readonly property color mint: "#77dd77"
    readonly property color gold: "#feb454"
    readonly property color goldAlt: "#ffb353"
    readonly property color orange: "#fe8f40"
    readonly property color orangeAlt: "#ff8f3f"
    readonly property color sand: "#e5b572"
    readonly property color peach: "#f29668"
    readonly property color red: "#ef7177"
    readonly property color purple: "#d2a6fe"
    readonly property color purpleAlt: "#d2a6ff"
    readonly property color bronze: "#997700"

    readonly property color text: "#bfbdb6"
    readonly property color textMuted: "#a6a5a0"
    readonly property color textDim: "#8c8b88"
    readonly property color sage: "#628b80"
    readonly property color slate: "#5a728b"
    readonly property color steel: "#5577aa"
    readonly property color gray: "#555555"
    readonly property color charcoal: "#333333"

    readonly property color background: "#dd000000"
    readonly property color surface: "#19ffffff"
    readonly property color surfaceStrong: "#33ffffff"
    readonly property color surfaceHover: "#44ffffff"
    readonly property color shadow: "#11000000"

    readonly property color selection: "#8866aadd"
    readonly property color selectionBlue: "#3d39bae5"
    readonly property color selectionOrange: "#3dfe8f40"
    readonly property color selectionPurple: "#3dd2a6fe"
    readonly property color selectionAqua: "#3d95e5cb"
    readonly property color selectionRed: "#3def7177"
    readonly property color selectionGold: "#3dfeb454"
    readonly property color selectionGreen: "#3daad84c"

    readonly property color positive: "#bb00ff00"
    readonly property color negative: "#bbff0000"
    readonly property color caution: "#bbffff00"

    readonly property color accent: blue
    readonly property color accentWarm: orange
    readonly property color highlight: bronze
    readonly property color muted: gray

    readonly property var accents: [blue, cyan, orange, purple, aqua, red, gold, green]

    function withAlpha(c, a) {
        return Qt.alpha(c, a);
    }
}
