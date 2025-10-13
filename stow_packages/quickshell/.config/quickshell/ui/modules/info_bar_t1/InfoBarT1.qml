pragma ComponentBehavior: Bound

import QtQuick

import qs.configs
import qs.ui.components.containers
import qs.ui.modules.info_bar_t1

MContainer {
  id: root

  property real textBoxSize: (isVertical ? 28 : 22)
  property color barBgColor: "#272e33"
  property color barSeparatorColor: "#9da9a0"
  property color clockFgColor: "#272e33"
  property color clockBgColor: "#a7c080"
  property color dateFgColor: "#272e33"
  property color dateBgColor: "#7fbbb3"

  property string orientation: "vertical"
  property real rounding: Config.styles.roundings.large
  property list<bool> contCornersToRound: [true, true, true, true]

  property bool includeSeparator: true
  property real barSepThickness: 3
  property real componentSepThickness: 2
  property real scale: 1

  readonly property bool isVertical: orientation === "vertical"

  // config to share to other components of this bar
  property QtObject sharedConfig: QtObject {
    property alias textBoxSize: root.textBoxSize
    property alias barBgColor: root.barBgColor
    property alias barSeparatorColor: root.barSeparatorColor
    property alias clockFgColor: root.clockFgColor
    property alias clockBgColor: root.clockBgColor
    property alias dateFgColor: root.dateFgColor
    property alias dateBgColor: root.dateBgColor

    property alias orientation: root.orientation
    property alias rounding: root.rounding
    property alias includeSeparator: root.includeSeparator
    property alias barSepThickness: root.barSepThickness
    property alias componentSepThickness: root.componentSepThickness
    property alias scale: root.scale
    property alias isVertical: root.isVertical
  }

  implicitHeight: {
    let horiPadding = Config.styles.paddings.extraSmall
    let vertPadding = Config.styles.paddings.regular
    let paddings = root.isVertical ? vertPadding : horiPadding

    return Math.round(loader.item.implicitHeight + paddings)
  }
  implicitWidth: {
    let horiPadding = Config.styles.paddings.regular
    let vertPadding = Config.styles.paddings.small * 0.7
    let paddings = root.isVertical ? vertPadding : horiPadding

    return Math.round(loader.item.implicitWidth + paddings)
  }

  bottomLeftRadius: Config.options.useRounding ? (contCornersToRound[0] ? rounding : 0) : 0
  bottomRightRadius: Config.options.useRounding ? (contCornersToRound[1] ? rounding : 0) : 0
  topRightRadius: Config.options.useRounding ? (contCornersToRound[2] ? rounding : 0) : 0
  topLeftRadius: Config.options.useRounding ? (contCornersToRound[3] ? rounding : 0) : 0

  color: root.barBgColor
  useAnimation: Config.options.useAnimation

  Component {
    id: horiBarComponents

    HoriBarComponents {
      config: root.sharedConfig
    }
  }

  Component {
    id: vertBarComponents

    VertBarComponents {
      config: root.sharedConfig
    }
  }

  Loader {
    id: loader

    // centers inside the container
    anchors.centerIn: parent

    sourceComponent: root.isVertical ? vertBarComponents : horiBarComponents
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
