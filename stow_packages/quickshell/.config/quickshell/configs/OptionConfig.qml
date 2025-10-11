import QtQuick
import Quickshell.Io

JsonObject {
    id: userOptions

    property string themeName: "theme_type_1"
    property string colorscheme: "everforest"
    // vertical || horizontal
    property string orientation: "vertical"
    property string windowManager: "hyprland"
    property bool showInactiveWs: true
    property int wsCount: 9
    property list<string> defaultWsNames: ["term", "editor", "file", "browser", "media", "books", "social", "settings", "misc"]

    // property bool useTwelveHourClock: Qt.locale().timeFormat(Locale.ShortFormat).toLowerCase().includes("a")
    property bool useTwelveHourClock: true
    // example: 01:21:PM
    property string twelveHourFormat: "hh:mm:AP"
    // example: 13:21
    property string twentyFourHourFormat: "hh:mm"
    // example: Sun:14:09
    property string dateFormat: "ddd:dd:MM"

    property bool useRounding: true
    property string themeMode: "dark"
}
