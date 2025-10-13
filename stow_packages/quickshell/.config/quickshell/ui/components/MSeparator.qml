// [NOTE]: this component must be used inside a Layout type

pragma ComponentBehavior: Bound

import QtQuick

import qs.ui.components.containers

MContainer {
  id: loader

  required property real length
  required property string orientation

  property real thickness: 1
  property real margins: 0
  property color separatorColor: "#202020"

  readonly property bool isVertical: this.orientation === "vertical"

  // if orientation is horizontal, the height should take all available space and the width should be the thickness
  // if orientation is vertical, the height should be the thickness and the width should take all available space
  implicitHeight: loader.isVertical ? loader.thickness : loader.length - (2 * margins)
  implicitWidth: loader.isVertical ? loader.length - (2 * margins) : loader.thickness

  color: loader.separatorColor
  // [DEBUG]: this makes it easy to debug layout issues
  // border{
  //   color: "#dc143c"
  // }
}
