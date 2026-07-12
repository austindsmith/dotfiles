import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import "../config"

Item {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property bool muted: sink?.audio?.muted ?? false
    readonly property int percent: Math.round((sink?.audio?.volume ?? 0) * 100)

    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    PwObjectTracker {
        objects: [root.sink]
    }

    RowLayout {
        id: row
        anchors.verticalCenter: parent.verticalCenter
        spacing: 6

        Text {
            text: {
                if (root.muted)
                    return "󰝟";
                if (root.accent < 34)
                    return "󰕿";
                if (root.percent < 67)
                    return "󰖀";
                return "󰕾";
            }
            color: root.muted ? Theme.accent : Theme.accent
            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSizeNormal
                bold: true
            }
        }

        Text {
            text: root.percent + "%"
            color: root.muted ? Theme.accent : Theme.accent
            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSizeNormal
                bold: true
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: event => {
            if (!root.sink?.audio)
                return;
            if (event.button === Qt.LeftButton)
                root.sink.audio.muted = !root.sink.audio.muted;
            else
                Quickshell.execDetached(["pavucontrol-qt"]);
        }
        onWheel: event => {
            if (!root.sink?.audio)
                return;
            const step = event.angleDelta.y > 0 ? 0.02 : -0.02;
            root.sink.audio.volume = Math.max(0, Math.min(1.5, root.sink.audio.volume + step));
        }
    }
}
