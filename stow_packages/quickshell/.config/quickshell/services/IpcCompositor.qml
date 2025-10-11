pragma Singleton

import Quickshell
import QtQuick

import qs.configs
import qs.services

Singleton {
  id: compositorIpc

  property bool isHyprland: false
  property bool isNiri: false

  property var compositor: {
    if (Config.options.windowManager == "hyprland") {
      return IpcHyprland
    }
    else {
      return IpcHyprland
    }
  }

  // function detectCompositor() {
  //   const hyprlandSignature = Quickshell.env("HYPRLAND_INSTANCE_SIGNATURE")
  //
  //   if (hyprlandSignature && hyprlandSignature.length > 0) {
  //     isHyprland = true
  //     isNiri = false
  //
  //     compositorIpc.compositor = Qt.createComponent("./IpcHyprland.qml", Component.Asynchronous)
  //   } else {
  //     // default to Niri
  //     isHyprland = false
  //     isNiri = true
  //
  //     compositorIpc.compositor = Qt.createComponent("./IpcNiri.qml", Component.Asynchronous)
  //   }
  // }
}
