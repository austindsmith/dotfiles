import Quickshell
import "config"
import "modules/bar"
import "modules/launcher"

ShellRoot {
    Bar {}
    Launcher {
        id: launcher
    }
}
