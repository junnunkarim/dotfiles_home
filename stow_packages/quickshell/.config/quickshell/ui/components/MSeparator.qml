// [NOTE]: this component must be used inside a Layout type

import QtQuick
import QtQuick.Layouts

import qs.configs

// [NOTE]: can't think of any better way to implement this, need better
// strategy and less redundancy
Loader {
  property string orientation: Config.options.orientation
  property real thickness: 1
  property real margins: 0
  property color separatorColor: "#202020"

  readonly property bool isVertical: this.orientation === "vertical"

  // [ISSUE]: can't seem to understand why setting both to true works in both
  // horizontal and vertical orientations
  Layout.fillHeight: true
  Layout.fillWidth: true

  // if orientation is horizontal
  Layout.topMargin: isVertical ? 0 : margins
  Layout.bottomMargin: isVertical ? 0 : margins
  // if orientation is vertical
  Layout.leftMargin: isVertical ? margins : 0
  Layout.rightMargin: isVertical ? margins : 0

  // this acts as the background container of the separator so
  // that we can center he separator inside this
  Rectangle {
    anchors.fill: parent

    color: "transparent"

    // [DEBUG]: this makes it easy to debug layout issues
    // border{
    //   color: "#dc143c"
    // }

    // the actual separator
    Rectangle {
      anchors.centerIn: parent

      // if orientation is horizontal, the height should take all available space and the width should be the thickness
      // if orientation is vertical, the height should be the thickness and the width should take all available space
      implicitHeight: isVertical ? thickness : parent.height
      implicitWidth: isVertical ? parent.width : thickness

      color: separatorColor
    }
  }
}
