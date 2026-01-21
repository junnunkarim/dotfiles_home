pragma ComponentBehavior: Bound

import QtQuick

import qs.ui.components.containers

MContainer {
  id: root

  // we are considering the MTextBox to be the lowest component, so
  // we are explicitly setting the height and width of it, and we
  // are going to make all components adjust around it
  required property real boxHeight
  required property real boxWidth

  property alias text: textItem.text

  property alias fgColor: textItem.color
  property alias fontColor: textItem.color
  property string contColor: "transparent"

  property alias fontSize: textItem.fontSize
  property alias fontFamily: textItem.fontFamily

  property alias useBold: textItem.useBold
  property alias fontWeight: textItem.fontWeight

  property alias fitMode: textItem.fitMode
  property alias orientation: textItem.orientation
  property alias rotationDirection: textItem.rotationDirection

  property alias useAnimation: textItem.useAnimation
  property alias animationDuration: textItem.animationDuration

  property alias isVertical: textItem.orientation

  implicitHeight: textItem.text != "" ? boxHeight : 0
  implicitWidth: textItem.text != "" ? boxWidth : 0

  color: contColor

  // [DEBUG]: this makes it easy to debug layout issues
  // border {
  //   color: "#dc143c"
  // }

  MText {
    id: textItem

    anchors.fill: parent
  }
}
