pragma ComponentBehavior: Bound

import QtQuick

import qs.configs
import qs.ui.components.containers

MContainer {
  id: textBox

  // we are considering the MTextBox to be the lowest component, so
  // we are explicitly setting the height and width of it, and we
  // are going to make all components adjust around it
  required property real boxHeight
  required property real boxWidth

  property alias text: textItem.text
  property alias fgColor: textItem.color
  property alias fontFamily: textItem.fontFamily
  property alias fontSize: textItem.fontSize
  property alias fontWeight: textItem.fontWeight
  property alias fitMode: textItem.fitMode
  property alias useAnimation: textItem.useAnimation
  property alias animationDuration: textItem.animationDuration

  property string bgColor: "transparent"
  property string orientation: "horizontal"
  readonly property bool isVertical: orientation == "vertical"

  implicitHeight: textItem.text != "" ? boxHeight * Config.styles.unit : 0
  implicitWidth: textItem.text != "" ? boxWidth * Config.styles.unit : 0

  color: bgColor

  // [DEBUG]: this makes it easy to debug layout issues
  // border {
  //   color: "#dc143c"
  // }

  MText {
    id: textItem

    anchors.centerIn: parent

    rotation: isVertical ? -90 : 0
    width: isVertical ? parent.height : parent.width
    height: isVertical ? parent.width : parent.height
  }
}
