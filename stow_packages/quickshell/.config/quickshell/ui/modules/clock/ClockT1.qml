pragma ComponentBehavior: Bound

import QtQuick

import qs.logic.configs
import qs.logic.services
import qs.ui.components
import qs.ui.components.containers

// clock background container
MContainer {
  id: root

  // colors
  property color fgColor: "#272e33"
  property color bgColor: "#a7c080"
  property color borderColor: "#e67e80"

  property int fontSize: isVertical ? Config.styles.fontSizes.sM : Config.styles.fontSizes.sS
  property string fontFamily: Config.styles.fontFamilies.sans
  property FontMetrics fontMetrics: FontMetrics {
    font.family: root.fontFamily
    font.pointSize: Math.round(root.fontSize * root.scale)
  }

  property bool useBorder: false
  property int borderWidth: 1

  property bool useRounding: Config.options.useRounding
  property real rounding: Config.styles.roundings.sS

  property bool includeSeparator: true
  property real separatorThickness: 2

  property real scale: Config.styles.scale
  property string orientation: Config.options.orientation

  // no need to multiply "scale" because the calculation is done in fontMetrics
  readonly property int boundHeight: Math.ceil(fontMetrics.height)
  // find out the maximum width needed to represent a character (only 1 char)
  // with current font size;
  readonly property int boundWidth: fontMetrics.boundingRect("W").width

  readonly property bool isVertical: orientation === "vertical"
  readonly property string clockFormat: Config.options.useTwelveHourClock ? Config.options.twelveHourFormat : Config.options.twentyFourHourFormat
  readonly property list<string> clockComponents: Time.format(clockFormat).split(":") ?? []
  // if clockComponents contains AM/PM information at 3rd index
  readonly property bool hasAmPm: clockComponents.length > 2

  implicitHeight: {
    let horiPadding = Config.styles.paddings.sXXS
    let vertPadding = Config.styles.paddings.sM

    let paddings = isVertical ? vertPadding : horiPadding

    return Math.round(loader.item.implicitHeight + (paddings * scale))
  }
  implicitWidth: {
    let horiPadding = Config.styles.paddings.sL
    let vertPadding = Config.styles.paddings.sL

    let paddings = isVertical ? vertPadding : horiPadding

    return Math.round(loader.item.implicitWidth + (paddings * scale))
  }

  color: bgColor
  radius: useRounding ? Math.round(rounding * scale) : 0
  border.color: borderColor
  border.width: useBorder ? borderWidth * scale : 0

  useAnimation: Config.options.useAnimation

  // component declaration
  // ---------------------
  // using inline component declaration for ClockSeparator and ClockText
  // because we need to reuse these components multiple times in this file

  component ClockText: MTextBox {
    boxHeight: root.boundHeight
    // if orientation is horizontal, we need to set the width in each component
    boxWidth: root.isVertical ? root.boundWidth * 2 : root.boundWidth

    fontColor: root.fgColor

    fontSize: Math.round(root.fontSize * root.scale)
    fontFamily: root.fontFamily
    
    fitMode: "fit"
    // orientation: "vertical"

    useAnimation: root.useAnimation
  }

  // only shown in 12-hour clock
  component ClockSeparator: Loader {
    id: sepLoader

    required property real length

    asynchronous: true
    active: root.includeSeparator && root.hasAmPm
    visible: active

    sourceComponent: MSeparator {
      length: sepLoader.length
      thickness: root.separatorThickness * root.scale
      margins: Math.round(sepLoader.length * 0.1)
      paddings: Math.round((isVertical ? Config.styles.paddings.sXXS : Config.styles.paddings.sXXS) * root.scale)
      separatorColor: root.fgColor
      orientation: root.orientation
      opacity: 0.5
    }
  }

  // only shown in 12-hour clock
  component AmPmIndicator: Loader {
    // asynchronous: true
    active: root.hasAmPm
    
    sourceComponent: ClockText {
      readonly property string data: root.clockComponents[2] ?? ""

      boxWidth: root.boundWidth * (root.isVertical ? 2 : data.length)

      text: root.hasAmPm ? data : ""
    }
  }

  // using Component type for horiClockLayout and vertClockLayout because
  // we only need to use these once

  // use when orientation is horizontal
  Component {
    id: horiLayout

    Row {
      anchors.centerIn: parent

      spacing: Math.round(Config.styles.margins.sXXXS * root.scale)

      // hour + minutes
      ClockText {
        readonly property string data: root.clockComponents[0] + ":" + root.clockComponents[1]

        anchors.verticalCenter: parent.verticalCenter
        boxWidth: root.boundWidth * data.length
        
        text: data
      }
      ClockSeparator {
        anchors.verticalCenter: parent.verticalCenter
        length: parent.height
      }
      AmPmIndicator {
        anchors.verticalCenter: parent.verticalCenter
      }
    }
  }

  // use when orientation is vertical
  Component {
    id: vertLayout

    Column {
      anchors.centerIn: parent

      spacing: -Math.round(Config.styles.margins.sXXXS * root.scale)

      // hour
      ClockText {
        anchors.horizontalCenter: parent.horizontalCenter

        text: root.clockComponents[0]
      }
      // minutes
      ClockText {
        anchors.horizontalCenter: parent.horizontalCenter

        text: root.clockComponents[1]
      }
      ClockSeparator {
        anchors.horizontalCenter: parent.horizontalCenter
        length: parent.width
      }
      AmPmIndicator {
        anchors.horizontalCenter: parent.horizontalCenter
      }
    }
  }

  Loader {
    id: loader

    anchors.centerIn: parent
    sourceComponent: root.isVertical ? vertLayout : horiLayout
  }
}
