import QtQuick
import Quickshell.Io

JsonObject {
  id: userOptions

  property string themeName: "elegant"
  property string colorscheme: "everforest"
  // vertical || horizontal
  property string orientation: "horizontal"
  property string windowManager: "niri"
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

  property int lowChargeThreshold: 20

  property bool useRounding: false
  property bool useAnimation: true
  property string themeMode: "dark"
  readonly property bool useDarkMode: themeMode === "dark"
}
