pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell 

import qs.configs
import qs.ui.components
import qs.ui.components.containers

Variants {
  // contains list of all available screens
  model: Quickshell.screens

  PanelWindow {
    id: clientBar

    // individual data from the "model" property can be accessed as "modelData"
    required property var modelData

    // set individual screen from the "model" property
    screen: modelData

    property real clientHeight: 12 
    property real clientWidth: 12

    property color barBgColor: "#272e33"
    property alias focusedColor: tagClients.focusedColor
    property alias unfocusedColor: tagClients.unfocusedColor
    property alias urgentColor: tagClients.urgentColor
    property string orientation: "horizontal"
    property real rounding: Config.styles.roundings.full

    readonly property bool isVertical: clientBar.orientation == "vertical"

    // attach the window to specific sides of the screen
    anchors {
      top: !clientBar.isVertical
      bottom: false
      left: true
      right: !clientBar.isVertical
    }

    implicitHeight: barContainer.implicitHeight
    implicitWidth: barContainer.implicitWidth

    color: "transparent"

    // background container inside bar window
    MContainer {
      id: barContainer

      anchors {
        right: parent.right
      }

      // anchors.fill: parent

      // than screen size
      implicitHeight: {
        var margins = clientBar.isVertical ? Config.styles.margins.extraLarge : Config.styles.margins.extraSmall

        return tagClients.implicitHeight + margins
      }
      implicitWidth: {
        var margins = clientBar.isVertical ? Config.styles.margins.extraSmall : Config.styles.margins.extraLarge

        return tagClients.implicitWidth + margins
        // return 38 * Config.options.defaultTagNames.length * Config.styles.unit
      }

      color: clientBar.barBgColor
      // when orientation is vertical set top-left and bottom-left radius
      topLeftRadius: Config.options.useRounding ? (clientBar.isVertical ? clientBar.rounding : 0) : 0
      bottomLeftRadius: Config.options.useRounding ? (clientBar.isVertical ? 0 : clientBar.rounding) : 0
      // when orientation is horizontal set top-right and bottom-right radius
      topRightRadius: 0
      bottomRightRadius: Config.options.useRounding ? (clientBar.isVertical ? clientBar.rounding : 0) : 0

      TagClients {
        id: tagClients

        anchors.centerIn: parent

        clientHeight: clientBar.clientHeight
        clientWidth: clientBar.clientWidth
        orientation: clientBar.orientation
      }
    }
  }
}
