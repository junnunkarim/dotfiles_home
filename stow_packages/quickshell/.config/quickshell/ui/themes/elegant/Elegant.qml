import QtQuick
import QtQuick.Window
import Quickshell

import qs.logic.configs
import qs.ui.components.containers
import qs.ui.modules.info_bar
import qs.ui.modules.ws_bar
import qs.ui.modules.client_bar

Variants {
  // contains list of all available screens
  model: Quickshell.screens

  PanelWindow {
    id: window

    // individual data from the "model" property can be accessed as "modelData"
    required property var modelData
    screen: modelData

    mask: Region {
      // y: Math.max(infoBar.height, wsBar.height, clientBar.height)
      height: Screen.height - infoBar.height
      // intersection: Intersection.Xor
    }
    exclusionMode: ExclusionMode.Ignore

    color: "transparent"

    property string orientation: Config.options.orientation
    readonly property bool isVertical: orientation == "vertical"

    anchors {
      top: true
      bottom: true
      left: true
      right: true
    }

    MExclusionArea {
      exclusiveZone: window.isVertical ? infoBar.implicitWidth : infoBar.implicitHeight
      anchors.right: window.isVertical ? true : false
      anchors.top: window.isVertical ? false : true
    }
    InfoBarT1 {
      id: infoBar

      anchors {
        // in vertical orientation
        right: isVertical ? parent.right : undefined
        verticalCenter: isVertical ? parent.verticalCenter : undefined
        // in horizontal orientation
        top: isVertical ? undefined : parent.top
        horizontalCenter: isVertical ? undefined : parent.horizontalCenter
      }
      // scale: 1.04

      orientation: window.orientation
      contCornersToRound: isVertical ? [true, false, false, true] : [true, true, false, false]
    }

    MExclusionArea {
      exclusiveZone: window.isVertical ?
        Math.max(wsBar.implicitHeight, clientBar.implicitHeight) :
        Math.max(wsBar.implicitWidth, clientBar.implicitWidth)
      anchors.top: window.isVertical ? true : false
    }
    WsBarT1 {
      id: wsBar

      anchors {
        left: parent.left
        top: parent.top
      }

      orientation: "horizontal"
      contCornersToRound: isVertical ? [false, true, false, false] : [false, true, false, false]
    }
    ClientBarT1 {
      id: clientBar

      anchors {
        right: parent.right
        top: parent.top
      }

      orientation: "horizontal"
      contCornersToRound: isVertical ? [false, false, true, false] : [true, false, false, false]
    }
  }
}
