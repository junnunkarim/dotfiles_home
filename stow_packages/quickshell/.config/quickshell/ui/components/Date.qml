// [NOTE]: this component must be used inside a Layout type

pragma ComponentBehavior: Bound

import QtQuick

import qs.configs
import qs.services
import qs.ui.components
import qs.ui.components.containers

// date background container
MContainer {
  id: dateBase

  property color fgColor: "#272e33"
  property color bgColor: "#7fbbb3"

  property real textBoxSize: isVertical ? 26 : 22
  property int fontSize: Config.styles.fontSizes.regular
  property string fontFamily: Config.styles.fontFamilies.sans

  property real rounding: Config.styles.roundings.regular * 0.7
  property real separatorThickness: 2
  property real scale: 1
  property bool includeSeparator: true
  property string orientation: Config.options.orientation

  readonly property bool isVertical: orientation === "vertical"
  readonly property string dateFormat: Config.options.dateFormat
  readonly property list<string> dateComponents: Time.format(dateFormat).split(":")

  implicitHeight: Math.round(loader.item.implicitHeight + (Config.styles.paddings.extraSmall * scale))
  implicitWidth: Math.round(loader.item.implicitWidth + ((isVertical ? Config.styles.paddings.extraSmall : Config.styles.paddings.small) * scale))

  color: bgColor
  radius: Config.options.useRounding ? rounding : 0

  useAnimation: true

  // component declaration
  // ---------------------
  // using inline component declaration for ClockSeparator and ClockText
  // because we need to reuse these components multiple times in this file

  component DateText: MTextBox {
    boxHeight: Math.round(dateBase.textBoxSize * Config.styles.unit * dateBase.scale)
    boxWidth: Math.round(dateBase.textBoxSize * Config.styles.unit * dateBase.scale)

    fgColor: dateBase.fgColor
    fontSize: dateBase.fontSize * dateBase.scale
    fontFamily: dateBase.fontFamily

    fitMode: isVertical ? "vertical" : "vertical"
  }

  component DateSeparator: Loader {
    id: sepLoader

    required property real length

    asynchronous: true
    active: dateBase.includeSeparator
    visible: active

    sourceComponent: MSeparator {
      anchors.centerIn: parent

      length: sepLoader.length
      thickness: dateBase.separatorThickness * dateBase.scale
      margins: Math.round(sepLoader.length * 0.05)
      separatorColor: dateBase.fgColor
      orientation: dateBase.orientation
      opacity: 0.5
    }
  }

  // using Component type for horiDateLayout and vertDateLayout because
  // i only need to use these once

  // use when orientation is horizontal
  Component {
    id: horiDateLayout

    Row {
      anchors.centerIn: parent

      spacing: (dateBase.textBoxSize * 0.2)

      // day of the week
      DateText {
        anchors.verticalCenter: parent.verticalCenter

        implicitWidth: Math.round(dateBase.textBoxSize * Config.styles.unit * dateBase.scale * 1.4)

        text: dateBase.dateComponents[0]
      }
      DateSeparator {
        anchors.verticalCenter: parent.verticalCenter
        length: parent.height
      }
      // day + month
      DateText {
        anchors.verticalCenter: parent.verticalCenter

        implicitWidth: Math.round(dateBase.textBoxSize * Config.styles.unit * dateBase.scale * 2.2)

        text: dateBase.dateComponents[1] + "/" + dateBase.dateComponents[2]
      }
    }
  }

  // use when orientation is vertical
  Component {
    id: vertDateLayout

    Column {
      anchors.centerIn: parent

      // spacing: 0
      spacing: Math.round(dateBase.textBoxSize * 0.1)

      // day of the week
      DateText {
        anchors.horizontalCenter: parent.horizontalCenter
        fitMode: "fit"

        // [TODO]: check if clockComponents[2] contains only the name of the
        // week days;
        text: dateBase.dateComponents[0]
      }
      DateSeparator {
        anchors.horizontalCenter: parent.horizontalCenter
        length: parent.width
      }
      // day
      DateText {
        anchors.horizontalCenter: parent.horizontalCenter

        text: dateBase.dateComponents[1]
      }
      // month
      DateText {
        anchors.horizontalCenter: parent.horizontalCenter

        text: dateBase.dateComponents[2]
      }
    }
  }

  Loader {
    id: loader

    // centers inside the container
    anchors.centerIn: parent
    sourceComponent: dateBase.isVertical ? vertDateLayout : horiDateLayout
  }
}
