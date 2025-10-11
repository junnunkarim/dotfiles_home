pragma ComponentBehavior: Bound

import QtQuick

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
  property alias animation: textItem.animation
  property alias animationProperty: textItem.animationProperty
  property alias animationFrom: textItem.animationFrom
  property alias animationTo: textItem.animationTo
  property alias animationDuration: textItem.animationDuration

  property string bgColor: "transparent"

  implicitHeight: textItem.text != "" ? boxHeight : 0
  implicitWidth: textItem.text != "" ? boxWidth : 0
  color: bgColor

  // [DEBUG]: this makes it easy to debug layout issues
  // border {
  //   color: "#dc143c"
  // }

  MText {
    id: textItem

    anchors.centerIn: parent

    height: parent.height
    width: parent.width
  }
}
