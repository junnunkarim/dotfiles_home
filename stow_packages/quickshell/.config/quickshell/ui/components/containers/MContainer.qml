pragma ComponentBehavior: Bound

import QtQuick

import qs.configs
import qs.ui.components.animations

Rectangle {
  id: root

  property bool useAnimation: false

  color: "transparent"

  // [DEBUG]: this makes it easy to debug layout issues
  // border {
  //   color: "#dc143c"
  // }

  Behavior on implicitHeight {
    enabled: root.useAnimation
    MSmoothAnimation {}
  }
  Behavior on implicitWidth {
    enabled: root.useAnimation
    MSmoothAnimation {}
  }
}
