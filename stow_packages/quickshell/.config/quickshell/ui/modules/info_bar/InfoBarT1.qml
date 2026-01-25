pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects

import qs.logic.configs
import qs.ui.components
import qs.ui.components.containers
import qs.ui.modules.info_bar

MContainer {
  id: root

  property color barBgColor: "#1f1d2e"
  property color barSeparatorColor: "#6e6a86"
  property color clockFgColor: "#1f1d2e"
  property color clockBgColor: "#ebbcba"
  property color clockBorderColor: "#ebbcba"
  property color dateFgColor: "#1f1d2e"
  property color dateBgColor: "#c4a7e7"
  property color dateBorderColor: "#c4a7e7"

  property bool useClockBorder: false
  property bool useDateBorder: false

  property int fontSize: isVertical ? Config.styles.fontSizes.sM : Config.styles.fontSizes.sS

  property bool useRounding: Config.options.useRounding
  property real rounding: Config.styles.roundings.sL
  property list<bool> contCornersToRound: [true, true, true, true]

  property bool includeSeparator: true
  property real barSepThickness: 3
  property real componentSepThickness: 2

  property real scale: Config.styles.scale
  property string orientation: "horizontal"

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
    let vertPadding = Config.styles.paddings.sL
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

  MouseArea {
    anchors.fill: parent
  }

  // shadow
  MElevation {
    anchors.fill: root
    level: 4
    radius: root.rounding
  }
}
