// [NOTE]: this component must be used inside a Layout type

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.configs
import qs.services
import qs.ui.components
import qs.ui.components.containers

// date background container
MContainer {
  id: dateBase

  property color fgColor: "#272e33"
  property color bgColor: "#7fbbb3"
  property int fontSize: Config.styles.fontSizes.regular
  property real textBoxSize: isVertical ? 30 : 27
  property real rounding: Config.styles.roundings.small
  property real separatorThickness: 2
  property real scale: 1
  property bool includeSeparator: true

  readonly property string dateFormat: Config.options.dateFormat
  readonly property list<string> dateComponents: Time.format(dateFormat).split(":")
  readonly property bool isVertical: Config.options.orientation === "vertical"

  // implicitHeight: loader.item.implicitHeight + (isVertical ? Config.styles.margins.small : Config.styles.margins.extraSmall)
  // implicitWidth: loader.item.implicitWidth + (isVertical ? Config.styles.margins.extraSmall : Config.styles.margins.small)
  implicitHeight: loader.item.implicitHeight + (Config.styles.margins.extraSmall * scale)
  implicitWidth: loader.item.implicitWidth + ((isVertical ? Config.styles.margins.extraSmall : Config.styles.margins.small) * scale)

  color: bgColor
  radius: Config.options.useRounding ? rounding : 0

  // component declaration
  // ---------------------
  // using inline component declaration for ClockSeparator and ClockText
  // because we need to reuse these components multiple times in this file

  component DateText: MTextBox {
    boxHeight: dateBase.textBoxSize * Config.styles.unit * dateBase.scale
    boxWidth: dateBase.textBoxSize * Config.styles.unit * dateBase.scale

    fgColor: dateBase.fgColor
    fontSize: dateBase.fontSize * dateBase.scale
    fontFamily: Config.styles.fontFamilies.sans
    fontWeight: 600
  }

  component DateSeparator: MSeparator {
    // [ISSUE]: doesn't show up if asynchronous is true
    // asynchronous: true
    active: dateBase.includeSeparator
    visible: active

    // no need to add margins because it's length is constraint by
    // RowLayout/ColumnLayout not by the main MContainer, so we are
    // getting automatic margin like behaviour as a side-effect
    separatorColor: dateBase.fgColor
    thickness: dateBase.separatorThickness
  }

  // using Component type for horiDateLayout and vertDateLayout because
  // i only need to use these once

  // use when orientation is horizontal
  Component {
    id: horiDateLayout

    RowLayout {
      anchors.centerIn: parent

      spacing: 0
      // spacing: (dateBase.fontSize * 0.4)

      // day of the week
      DateText {
        Layout.alignment: Qt.AlignVCenter

        implicitWidth: dateBase.textBoxSize * Config.styles.unit * dateBase.scale * 1.4

        text: dateBase.dateComponents[0]
      }
      DateSeparator {
        Layout.alignment: Qt.AlignVCenter
        Layout.leftMargin: dateBase.fontSize * 0.2
        Layout.rightMargin: dateBase.fontSize * 0.2
      }
      // day + month
      DateText {
        Layout.alignment: Qt.AlignVCenter
        implicitWidth: dateBase.textBoxSize * Config.styles.unit * dateBase.scale * 2.2

        text: dateBase.dateComponents[1] + "/" + dateBase.dateComponents[2]
      }
    }
  }

  // use when orientation is vertical
  Component {
    id: vertDateLayout

    ColumnLayout {
      anchors.centerIn: parent

      spacing: 0
      // spacing: (dateBase.fontSize * 0.2)

      // day of the week
      DateText {
        Layout.alignment: Qt.AlignHCenter

        fontSize: dateBase.fontSize * dateBase.scale
        // [TODO]: check if clockComponents[2] contains only the name of the
        // week days;
        // first two letters
        text: dateBase.dateComponents[0]
      }
      DateSeparator {
        Layout.alignment: Qt.AlignHCenter
        Layout.topMargin: dateBase.fontSize * 0.2
        Layout.bottomMargin: dateBase.fontSize * 0.2
      }
      // day
      DateText {
        Layout.alignment: Qt.AlignHCenter

        text: dateBase.dateComponents[1]
      }
      // month
      DateText {
        Layout.alignment: Qt.AlignHCenter

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
