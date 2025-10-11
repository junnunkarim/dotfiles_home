// [NOTE]: this component must be used inside a Layout type

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

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
  property int fontSize: Config.styles.fontSizes.regular
  property real textBoxSize: (isVertical ? 30 : 27)
  property real rounding: Config.styles.roundings.small
  property real separatorThickness: 2
  property real scale: 1
  property bool includeSeparator: true

  readonly property string clockFormat: Config.options.useTwelveHourClock ? Config.options.twelveHourFormat : Config.options.twentyFourHourFormat
  // [TODO]: handle index bounds
  readonly property list<string> clockComponents: Time.format(clockFormat).split(":")
  // if clockComponents has contains data in 3rd index
  readonly property bool hasAmPm: clockComponents.length > 2
  readonly property bool isVertical: Config.options.orientation === "vertical"

  // implicitHeight: loader.item.implicitHeight + (isVertical ? Config.styles.margins.small : Config.styles.margins.extraSmall)
  implicitHeight: loader.item.implicitHeight + (Config.styles.margins.extraSmall * scale)
  implicitWidth: loader.item.implicitWidth + ((isVertical ? Config.styles.margins.extraSmall : Config.styles.margins.small) * scale)

  color: bgColor
  radius: Config.options.useRounding ? rounding : 0

  // component declaration
  // ---------------------
  // using inline component declaration for ClockSeparator and ClockText
  // because we need to reuse these components multiple times in this file

  component ClockText: MTextBox {
    boxHeight: clockBase.textBoxSize * Config.styles.unit * clockBase.scale
    boxWidth: clockBase.textBoxSize * Config.styles.unit * clockBase.scale

    fgColor: clockBase.fgColor
    fontSize: clockBase.fontSize * clockBase.scale
    fontFamily: Config.styles.fontFamilies.sans
    fontWeight: 600
  }

  // only shown in 12-hour clock
  component ClockSeparator: MSeparator {
    // [ISSUE]: doesn't show up if asynchronous is true
    // asynchronous: true
    active: clockBase.includeSeparator && clockBase.hasAmPm
    visible: active

    // no need to add margins because it's length is constraint by
    // RowLayout/ColumnLayout not by the main MContainer, so we are
    // getting automatic margin like behaviour as a side-effect
    separatorColor: clockBase.fgColor
    thickness: clockBase.separatorThickness
  }

  // only shown in 12-hour clock
  component AmPmIndicator: Loader {
    // [ISSUE]: doesn't show up when quickshell starts up if asynchronous is true
    // asynchronous: true
    active: clockBase.hasAmPm
    
    sourceComponent: ClockText {
      // [TODO]: check if clockComponents[2] contains either "AM" or "PM";
      text: clockBase.hasAmPm ? clockBase.clockComponents[2] : ""
    }
  }

  // using Component type for horiClockLayout and vertClockLayout because
  // i only need to use these once

  // use when orientation is horizontal
  Component {
    id: horiClockLayout

    RowLayout {
      anchors.centerIn: parent

      spacing: 0
      // spacing: (clockBase.fontSize * 0.4)

      // hour + minutes
      ClockText {
        Layout.alignment: Qt.AlignVCenter
        
        implicitWidth: clockBase.textBoxSize * Config.styles.unit * clockBase.scale * 2.2

        text: clockBase.clockComponents[0] + ":" + clockBase.clockComponents[1]
      }
      ClockSeparator {
        Layout.alignment: Qt.AlignVCenter
        Layout.leftMargin: clockBase.fontSize * 0.2
        Layout.rightMargin: clockBase.fontSize * 0.2
      }
      AmPmIndicator {
        Layout.alignment: Qt.AlignVCenter
      }
    }
  }

  // use when orientation is vertical
  Component {
    id: vertClockLayout

    ColumnLayout {
      anchors.centerIn: parent

      spacing: 0
      // spacing: (clockBase.fontSize * 0.2)

      // hour
      ClockText {
        Layout.alignment: Qt.AlignHCenter

        text: clockBase.clockComponents[0]
      }
      // minutes
      ClockText {
        Layout.alignment: Qt.AlignHCenter

        text: clockBase.clockComponents[1]
      }
      ClockSeparator {
        Layout.alignment: Qt.AlignHCenter
        Layout.topMargin: clockBase.fontSize * 0.2
        Layout.bottomMargin: clockBase.fontSize * 0.2
      }
      AmPmIndicator {
        Layout.alignment: Qt.AlignHCenter
      }
    }
  }

  Loader {
    id: loader

    // centers inside the container
    anchors.centerIn: parent

    sourceComponent: isVertical ? vertClockLayout : horiClockLayout
  }
}
