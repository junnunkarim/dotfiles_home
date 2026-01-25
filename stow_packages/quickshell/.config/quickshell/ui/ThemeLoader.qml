import Quickshell
import QtQuick

import qs.logic.configs
import qs.ui.themes.elegant

Loader {
  readonly property Component selectedTheme: {
    switch (Config.options.themeName) {
      case "elegant":
        return Qt.createComponent("./themes/elegant/Elegant.qml", Component.Asynchronous);
      default:
        return Qt.createComponent("./themes/elegant/Elegant.qml", Component.Asynchronous);
    }
  }

  sourceComponent: selectedTheme
}
