pragma ComponentBehavior: Bound

import QtQuick

import qs.configs
import qs.services
import qs.ui.components
import qs.ui.components.containers

// date background container
MContainer {
  id: root

  // colors
  property color fgColor: "#272e33"
  property color bgColor: "#7fbbb3"
  property color borderColor: "#e67e80"

  property int fontSize: isVertical ? Config.styles.fontSizes.sM : Config.styles.fontSizes.sS
  property string fontFamily: Config.styles.fontFamilies.sans
  property FontMetrics fontMetrics: FontMetrics {
    font.family: root.fontFamily
    font.pointSize: Math.round(root.fontSize * root.scale)
  }
  // Component.onCompleted: {
  //   console.log("[DEBUG] fontSize", Math.ceil(root.fontSize))
  //   console.log("[DEBUG] fontMetrics height", Math.ceil(root.fontMetrics.height))
  //   console.log("[DEBUG] fontMetrics boundingRect width", root.fontMetrics.boundingRect("WW").width)
  //   console.log("[DEBUG] fontMetrics advanceWidth", root.fontMetrics.advanceWidth("WW"))
  //   console.log("[DEBUG] fontMetrics width", root.fontMetrics.maximumCharacterWidth)
  //   console.log("[DEBUG] boundHeight", root.boundHeight)
  //   console.log("[DEBUG] boundWidth", root.boundWidth)
  // }

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
  readonly property string dateFormat: Config.options.dateFormat
  readonly property list<string> dateComponents: Time.format(dateFormat).split(":")

  implicitHeight: {
    let horiPadding = Config.styles.paddings.sXXS
    let vertPadding = Config.styles.paddings.sM

    let paddings = isVertical ? vertPadding : horiPadding

    return Math.round(loader.item.implicitHeight + (paddings * scale))
  }
  implicitWidth: {
    let horiPadding = Config.styles.paddings.sL
    let vertPadding = Config.styles.paddings.sM

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

  component DateText: MTextBox {
    boxHeight: root.boundHeight
    // if orientation is horizontal, we need to set the width in each component
    boxWidth: root.isVertical ? root.boundWidth * 2 : undefined

    fontColor: root.fgColor

    fontSize: Math.round(root.fontSize * root.scale)
    fontFamily: root.fontFamily
    
    fitMode: "fit"
    // orientation: "vertical"
  }

  component DateSeparator: Loader {
    id: sepLoader

    required property real length

    asynchronous: true
    active: root.includeSeparator
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

  // using Component type for horiDateLayout and vertDateLayout because
  // i only need to use these once

  // use when orientation is horizontal
  Component {
    id: horiLayout

    Row {
      anchors.centerIn: parent

      spacing: Math.round(Config.styles.margins.sXXXS * root.scale)

      // day of the week
      DateText {
        anchors.verticalCenter: parent.verticalCenter
        boxWidth: root.boundWidth * root.dateComponents[0].length

        text: root.dateComponents[0]
      }
      DateSeparator {
        anchors.verticalCenter: parent.verticalCenter
        length: parent.height
      }
      // day + month
      DateText {
        readonly property string data: root.dateComponents[1] + "/" + root.dateComponents[2]

        anchors.verticalCenter: parent.verticalCenter
        boxWidth: root.boundWidth * data.length

        text: data
      }
    }
  }

  // use when orientation is vertical
  Component {
    id: vertLayout

    Column {
      anchors.centerIn: parent

      spacing: -Math.round(Config.styles.margins.sXXXS * root.scale)

      // day of the week
      DateText {
        anchors.horizontalCenter: parent.horizontalCenter

        text: root.dateComponents[0]
      }
      DateSeparator {
        anchors.horizontalCenter: parent.horizontalCenter
        length: parent.width
      }
      // day
      DateText {
        anchors.horizontalCenter: parent.horizontalCenter

        text: root.dateComponents[1]
      }
      // month
      DateText {
        anchors.horizontalCenter: parent.horizontalCenter

        text: root.dateComponents[2]
      }
    }
  }

  Loader {
    id: loader

    // centers inside the container
    anchors.centerIn: parent
    sourceComponent: root.isVertical ? vertLayout : horiLayout
  }
}
