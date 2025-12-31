import Quickshell
import QtQuick

import qs.logic.configs
import qs.ui.themes.theme_type_1

Loader {
  readonly property Component selectedTheme: {
    switch (Config.options.themeName) {
      case "theme_type1":
        return Qt.createComponent("./themes/theme_type_1/ThemeType1.qml", Component.Asynchronous);
      default:
        return Qt.createComponent("./themes/theme_type_1/ThemeType1.qml", Component.Asynchronous);
    }
  }

  sourceComponent: selectedTheme
}
