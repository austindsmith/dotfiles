pragma Singleton

import QtQuick

QtObject {
    id: launcherState

    property bool visible: false

    function toggle() {
        visible = !visible;
    }
}
