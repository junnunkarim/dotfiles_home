import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import qs.configs
import qs.ui.components
import qs.ui.components.containers
import qs.ui.modules.info_bar_t1.components

Variants {
  id: infoBar

  // contains list of all available screens
  model: Quickshell.screens

  // default properties
  property real textBoxSize: (isVertical ? 30 : 27)
  property color barBgColor: "#272e33"
  property color barSeparatorColor: "#9da9a0"
  property color clockFgColor: "#272e33"
  property color clockBgColor: "#a7c080"
  property color dateFgColor: "#272e33"
  property color dateBgColor: "#7fbbb3"
  property real rounding: Config.styles.roundings.large
  property bool includeSeparator: true
  property real barSepThickness: 3
  property real componentSepThickness: 2
  property real scale: 1

  readonly property bool isVertical: Config.options.orientation === "vertical"

  // config to share to other components of this bar
  property QtObject sharedConfig: QtObject {
    property real textBoxSize: infoBar.textBoxSize
    property color barBgColor: infoBar.barBgColor
    property color barSeparatorColor: infoBar.barSeparatorColor
    property color clockFgColor: infoBar.clockFgColor
    property color clockBgColor: infoBar.clockBgColor
    property color dateFgColor: infoBar.dateFgColor
    property color dateBgColor: infoBar.dateBgColor
    property real rounding: infoBar.rounding
    property bool includeSeparator: infoBar.includeSeparator
    property real barSepThickness: infoBar.barSepThickness
    property real componentSepThickness: infoBar.componentSepThickness
    property real scale: infoBar.scale
    property bool isVertical: infoBar.isVertical
  }

  PanelWindow {
    // individual data from the "model" property can be accessed as "modelData"
    required property var modelData

    // exclusiveZone: 0

    // set individual screen from the "model" property
    screen: modelData

    // attach the window to specific sides of the screen
    anchors {
      top: !infoBar.isVertical
      bottom: false
      left: false
      right: infoBar.isVertical
    }
    // [TODO]: handle case where implicitHeight or implicitHeight is greater
    implicitHeight: barContainer.implicitHeight
    implicitWidth: barContainer.implicitWidth

    color: "transparent"

    // debug
    Component.onCompleted: {
      console.log(`[INFO] barContainer.implicitHeight: ${barContainer.implicitHeight}`)
      console.log(`[INFO] barContainer.implicitWidth: ${barContainer.implicitWidth}`)
    }

    // background container inside bar window
    MContainer {
      id: barContainer

      anchors.fill: parent

      // than screen size
      implicitHeight: {
        var margins = infoBar.isVertical ? Config.styles.margins.regular : Config.styles.margins.extraSmall

        return loader.item.implicitHeight + margins
      }
      implicitWidth: {
        var margins = infoBar.isVertical ? Config.styles.margins.extraSmall + 1 : Config.styles.margins.extraLarge

        return loader.item.implicitWidth + margins
      }

      color: infoBar.barBgColor
      // when orientation is vertical set top-left and bottom-left radius
      topLeftRadius: Config.options.useRounding ? (infoBar.isVertical ? infoBar.rounding : 0) : 0
      bottomLeftRadius: Config.options.useRounding ? (infoBar.isVertical ? infoBar.rounding : infoBar.rounding) : 0
      // when orientation is horizontal set top-right and bottom-right radius
      topRightRadius: 0
      bottomRightRadius: Config.options.useRounding ? (infoBar.isVertical ? 0 : infoBar.rounding) : 0

      Component {
        id: horiBarComponents

        HoriBarComponents {
          config: sharedConfig
        }
      }

      Component {
        id: vertBarComponents

        VertBarComponents {
          config: sharedConfig
        }
      }

      Loader {
        id: loader

        // centers inside the container
        anchors.centerIn: parent

        sourceComponent: infoBar.isVertical ? vertBarComponents : horiBarComponents
      }
    }

    // MultiEffect {
    //   source: barContainer
    //   anchors.fill: barContainer
    //   shadowBlur: 2.0
    //   shadowEnabled: true
    //   shadowColor: "white"
    //   shadowVerticalOffset: 25
    //   shadowHorizontalOffset: 21
    // }
  }
}
