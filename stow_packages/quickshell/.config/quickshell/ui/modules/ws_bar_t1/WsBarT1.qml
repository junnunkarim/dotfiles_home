pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell 

import qs.configs
import qs.ui.components
import qs.ui.components.animations
import qs.ui.components.containers

Variants {
  // contains list of all available screens
  model: Quickshell.screens

  PanelWindow {
    id: wsBar

    // individual data from the "model" property can be accessed as "modelData"
    required property var modelData

    // set individual screen from the "model" property
    screen: modelData

    property string orientation: "horizontal"

    readonly property bool isVertical: wsBar.orientation == "vertical"

    // attach the window to specific sides of the screen
    anchors {
      top: !wsBar.isVertical
      bottom: false
      left: true
      right: !wsBar.isVertical
    }

    implicitHeight: wsList.implicitHeight
    implicitWidth: wsList.implicitWidth

    color: "transparent"

    WorkspaceList {
      id: wsList
    }
  }
}
