// [NOTE]: this component must be used inside a Layout type

pragma ComponentBehavior: Bound

import QtQuick

import qs.configs
import qs.services
import qs.ui.components
import qs.ui.components.containers

// clock background container
MContainer {
  id: clockBase

  // default properties
  property color fgColor: "#272e33"
  property color bgColor: "#a7c080"

  property real textBoxSize: isVertical ? 26 : 22
  property int fontSize: Config.styles.fontSizes.regular
  property string fontFamily: Config.styles.fontFamilies.sans

  property real rounding: Config.styles.roundings.small
  property real separatorThickness: 2
  property real scale: 1
  property bool includeSeparator: true
  property string orientation: Config.options.orientation

  readonly property bool isVertical: orientation === "vertical"
  readonly property string clockFormat: Config.options.useTwelveHourClock ? Config.options.twelveHourFormat : Config.options.twentyFourHourFormat
  // [TODO]: handle index bounds
  readonly property list<string> clockComponents: Time.format(clockFormat).split(":")
  // if clockComponents contains data in 3rd index
  readonly property bool hasAmPm: clockComponents.length > 2

  // implicitHeight: loader.item.implicitHeight + (isVertical ? Config.styles.paddings.small : Config.styles.paddings.extraSmall)
  implicitHeight: Math.round(loader.item.implicitHeight + (Config.styles.paddings.extraSmall * scale))
  implicitWidth: Math.round(loader.item.implicitWidth + ((isVertical ? Config.styles.paddings.extraSmall : Config.styles.paddings.small) * scale))

  color: bgColor
  radius: Config.options.useRounding ? rounding : 0

  useAnimation: true

  // component declaration
  // ---------------------
  // using inline component declaration for ClockSeparator and ClockText
  // because we need to reuse these components multiple times in this file

  component ClockText: MTextBox {
    boxHeight: Math.round(clockBase.textBoxSize * Config.styles.unit * clockBase.scale)
    boxWidth: Math.round(clockBase.textBoxSize * Config.styles.unit * clockBase.scale)

    fgColor: clockBase.fgColor

    fontSize: clockBase.fontSize * clockBase.scale
    fontFamily: clockBase.fontFamily

    fitMode: clockBase.isVertical ? "vertical" : "vertical"
  }

  // only shown in 12-hour clock
  component ClockSeparator: Loader {
    id: sepLoader

    required property real length

    asynchronous: true
    active: clockBase.includeSeparator && clockBase.hasAmPm
    visible: active

    sourceComponent: MSeparator {
      length: sepLoader.length
      thickness: clockBase.separatorThickness * clockBase.scale
      margins: Math.round(sepLoader.length * 0.05)
      separatorColor: clockBase.fgColor
      orientation: clockBase.orientation
      opacity: 0.5
    }
  }

  // only shown in 12-hour clock
  component AmPmIndicator: Loader {
    // asynchronous: true
    active: clockBase.hasAmPm
    
    sourceComponent: ClockText {
      fitMode: "fit"
      // [TODO]: check if clockComponents[2] contains either "AM" or "PM";
      text: clockBase.hasAmPm ? clockBase.clockComponents[2] : ""
    }
  }

  // using Component type for horiClockLayout and vertClockLayout because
  // we only need to use these once

  // use when orientation is horizontal
  Component {
    id: horiClockLayout

    Row {
      anchors.centerIn: parent

      // spacing: 0
      spacing: Math.round(clockBase.textBoxSize * 0.2)

      // hour + minutes
      ClockText {
        anchors.verticalCenter: parent.verticalCenter
        
        implicitWidth: Math.round(clockBase.textBoxSize * Config.styles.unit * clockBase.scale * 2.2)

        text: clockBase.clockComponents[0] + ":" + clockBase.clockComponents[1]
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
    id: vertClockLayout

    Column {
      anchors.centerIn: parent

      // spacing: 0
      spacing: Math.round(clockBase.textBoxSize * 0.1)

      // hour
      ClockText {
        anchors.horizontalCenter: parent.horizontalCenter
        text: clockBase.clockComponents[0]
      }
      // minutes
      ClockText {
        anchors.horizontalCenter: parent.horizontalCenter
        text: clockBase.clockComponents[1]
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
    sourceComponent: clockBase.isVertical ? vertClockLayout : horiClockLayout
  }
}
