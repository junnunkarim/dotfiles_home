pragma Singleton

import Quickshell
import QtQuick

import qs.logic.configs

Singleton {
  id: compositorIpc

  property Item compositor: null

  Component.onCompleted: {
    switch (Config.options.windowManager) {
      case "hyprland":
        compositorIpc.compositor =  Qt.createComponent("./compositor/IpcHyprland.qml").createObject()
        break;
      case "niri":
        compositorIpc.compositor =  Qt.createComponent("./compositor/IpcNiri.qml").createObject()
        break;
      default:
        compositorIpc.compositor =  Qt.createComponent("./compositor/IpcHyprland.qml").createObject()
    }
  }
}
