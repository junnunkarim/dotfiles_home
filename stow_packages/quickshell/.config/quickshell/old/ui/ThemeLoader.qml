import Quickshell
import QtQuick

import qs.configs
import qs.ui.themes.elegant

Loader {
  id: themeLoader

  Component.onCompleted: {
    switch (Config.options.themeName) {
      default:
        themeLoader.source = "ui/themes/elegant/Elegant.qml";
    }
  }
  // readonly property Component selectedTheme: {
  //   switch (Config.options.themeName) {
  //     case "elegant":
  //       return Qt.createComponent("./themes/elegant/Elegant.qml", Component.Asynchronous);
  //     default:
  //       return Qt.createComponent("./themes/elegant/Elegant.qml", Component.Asynchronous);
  //   }
  // }
  //
  // sourceComponent: selectedTheme
}
