pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects

import qs.configs
import qs.ui.components.containers
import qs.ui.modules.info_bar_t1

MContainer {
  id: root

  property color barBgColor: "#272e33"
  property color barSeparatorColor: "#9da9a0"
  property color clockFgColor: "#272e33"
  property color clockBgColor: "#a7c080"
  property color clockBorderColor: "#a7c080"
  property color dateFgColor: "#272e33"
  property color dateBgColor: "#7fbbb3"
  property color dateBorderColor: "#7fbbb3"

  property bool useClockBorder: false
  property bool useDateBorder: false

  property int fontSize: isVertical ? Config.styles.fontSizes.sM : Config.styles.fontSizes.sS

  property bool useRounding: Config.options.useRounding
  property real rounding: Config.styles.roundings.sL
  property list<bool> contCornersToRound: [true, true, true, true]

  property bool includeSeparator: true
  property real barSepThickness: 3
  property real componentSepThickness: 2

  property real scale: 1
  property string orientation: "vertical"

  readonly property bool isVertical: orientation === "vertical"

  // config to share to other components of this bar
  property QtObject sharedConfig: QtObject {
    id: config

    property alias barBgColor: root.barBgColor
    property alias barSeparatorColor: root.barSeparatorColor
    property alias clockFgColor: root.clockFgColor
    property alias clockBgColor: root.clockBgColor
    property alias clockBorderColor: root.clockBorderColor
    property alias dateFgColor: root.dateFgColor
    property alias dateBgColor: root.dateBgColor
    property alias dateBorderColor: root.dateBorderColor

    property alias useClockBorder: root.useClockBorder
    property alias useDateBorder: root.useDateBorder

    property alias fontSize: root.fontSize

    property alias orientation: root.orientation
    property alias rounding: root.rounding
    property alias contCornersToRound: root.contCornersToRound

    property alias includeSeparator: root.includeSeparator
    property alias barSepThickness: root.barSepThickness
    property alias componentSepThickness: root.componentSepThickness
    property alias scale: root.scale

    property alias isVertical: root.isVertical

  }

  implicitHeight: {
    let horiPadding = Config.styles.paddings.sS
    let vertPadding = Config.styles.paddings.sXXL
    let paddings = (root.isVertical ? vertPadding : horiPadding) * root.scale

    return Math.round(loader.item.implicitHeight + paddings)
  }
  implicitWidth: {
    let horiPadding = Config.styles.paddings.sXXL
    let vertPadding = Config.styles.paddings.sM
    let paddings = (root.isVertical ? vertPadding : horiPadding) * root.scale

    return Math.round(loader.item.implicitWidth + paddings)
  }

  bottomLeftRadius: useRounding ? (contCornersToRound[0] ? rounding : 0) : 0
  bottomRightRadius: useRounding ? (contCornersToRound[1] ? rounding : 0) : 0
  topRightRadius: useRounding ? (contCornersToRound[2] ? rounding : 0) : 0
  topLeftRadius: useRounding ? (contCornersToRound[3] ? rounding : 0) : 0

  color: root.barBgColor
  useAnimation: Config.options.useAnimation

  Component {
    id: horiLayout

    HoriLayout {
      anchors.centerIn: parent
      config: root.sharedConfig
    }
  }

  Component {
    id: vertLayout

    VertLayout {
      anchors.centerIn: parent
      config: root.sharedConfig
    }
  }

  Loader {
    id: loader

    // centers inside the container
    anchors.centerIn: parent

    sourceComponent: root.isVertical ? vertLayout : horiLayout
  }

  // shadow
  RectangularShadow {
    anchors.fill: root
    z: -1
    blur: 20
    opacity: 0.8
    color: root.color
    offset.y: 5
  }
}
