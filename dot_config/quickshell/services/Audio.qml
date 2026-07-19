import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import "../config"

Item {
    id: root
    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property bool muted: sink?.audio?.muted ?? false
    readonly property int percent: Math.round((sink?.audio?.volume ?? 0) * 100)

    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    function openPopup() {
        popup.visible = true;
        grab.active = true;
    }

    function closePopup() {
        grab.active = false;
        popup.visible = false;
    }

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
                if (root.percent < 34)
                    return "󰕿";
                if (root.percent < 67)
                    return "󰖀";
                return "󰕾";
            }
            color: Theme.accent
            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSizeNormal
                bold: true
            }
        }

        Text {
            text: root.percent + "%"
            color: Theme.accent
            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSizeNormal
                bold: true
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
        onClicked: event => {
            if (!root.sink?.audio)
                return;
            if (event.button === Qt.LeftButton) {
                if (popup.visible)
                    root.closePopup();
                else
                    root.openPopup();
            } else if (event.button === Qt.MiddleButton)
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

    PopupWindow {
        id: popup
        visible: false
        color: "transparent"
        implicitWidth: 280
        implicitHeight: card.implicitHeight

        anchor {
            item: root
            rect.y: root.height + 6
            rect.x: root.width / 2 - popup.implicitWidth / 2
        }

        HyprlandFocusGrab {
            id: grab
            windows: [popup]
            onCleared: root.closePopup()
        }

        Rectangle {
            id: card
            anchors.fill: parent
            implicitHeight: content.implicitHeight + 28
            radius: 10
            color: Theme.background
            border.color: Theme.accent
            border.width: 1

            ColumnLayout {
                id: content
                anchors.fill: parent
                anchors.margins: 14
                spacing: 10

                RowLayout {
                    Layout.fillWidth: true

                    Text {
                        text: root.sink?.description ?? "No sink"
                        color: Theme.accent
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                        font {
                            family: Theme.fontFamily
                            pixelSize: Theme.fontSizeNormal
                        }
                    }
                    Text {
                        text: root.percent + "%"
                        color: Theme.accent
                        font {
                            family: Theme.fontFamily
                            pixelSize: Theme.fontSizeNormal
                            bold: true
                        }
                    }
                }
                RowLayout {
                    Text {
                        text: {
                            if (root.muted)
                                return "󰝟";
                            if (root.percent < 34)
                                return "󰕿";
                            if (root.percent < 67)
                                return "󰖀";
                            return "󰕾";
                        }
                        color: Theme.accent
                        font {
                            family: Theme.fontFamily
                            pixelSize: Theme.fontSizeNormal
                            bold: true
                        }
                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton
                            onClicked: event => {
                                if (!root.sink?.audio)
                                    return;
                                if (event.button === Qt.LeftButton)
                                    root.sink.audio.muted = !root.sink.audio.muted;
                            }
                        }
                    }
                    Slider {
                        Layout.fillWidth: true
                        from: 0
                        to: 1.5
                        value: root.sink?.audio?.volume ?? 0
                        onMoved: {
                            if (root.sink?.audio)
                                root.sink.audio.volume = value;
                        }
                    }
                }
            }
        }
    }
}
