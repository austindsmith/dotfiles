import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import "../../config"

Repeater {
    model: SystemTray.items

    IconImage {
        id: trayIcon

        required property SystemTrayItem modelData

        implicitSize: 16
        source: modelData.icon

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
            onClicked: event => {
                if (event.button === Qt.LeftButton)
                    trayIcon.modelData.activate();
                else if (event.button === Qt.MiddleButton)
                    trayIcon.modelData.secondaryActivate();
                else if (trayIcon.modelData.hasMenu)
                    menuAnchor.open();
            }
        }

        QsMenuAnchor {
            id: menuAnchor
            menu: trayIcon.modelData.menu
            anchor.item: trayIcon
            anchor.edges: Edges.Bottom
            anchor.gravity: Edges.Bottom
        }
        Component.onCompleted: {
            console.log(modelData.id);
            console.log(modelData.icon);
        }
    }
}
