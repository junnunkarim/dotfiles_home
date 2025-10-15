pragma ComponentBehavior: Bound

import QtQuick

import qs.ui.components.containers

MContainer {
  id: root

  required property real length
  required property string orientation

  property real thickness: 1
  property real margins: 0
  property real paddings: 0
  property color separatorColor: "#202020"

  readonly property bool isVertical: this.orientation === "vertical"

  implicitHeight: sep.implicitHeight + (isVertical ? (paddings * 2) : 0)
  implicitWidth: sep.implicitWidth + (isVertical ? 0 : (paddings * 2))

  color: "transparent"
  // [DEBUG]: this makes it easy to debug layout issues
  // border{
  //   color: "#dc143c"
  // }

  MContainer {
    id: sep

    anchors.centerIn: parent

    // if orientation is horizontal, the height should take all available space and the width should be the thickness
    // if orientation is vertical, the height should be the thickness and the width should take all available space
    implicitHeight: root.isVertical ? root.thickness : root.length - (2 * margins)
    implicitWidth: root.isVertical ? root.length - (2 * margins) : root.thickness

    color: root.separatorColor
  }
}
