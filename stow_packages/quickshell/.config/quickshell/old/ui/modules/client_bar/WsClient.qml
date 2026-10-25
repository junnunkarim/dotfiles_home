pragma ComponentBehavior: Bound

import QtQuick

import qs.logic.configs
import qs.ui.components.containers

MContainer {
  id: root

  required property real itemHeight
  required property real itemWidth

  required property color defaultColor
  required property color focusColor
  required property color urgentColor
  required property color specialWsColor

  required property bool isFocused
  required property bool isUrgent
  required property bool insideSpecialWs

  required property string orientation
  required property real focusedRounding
  required property real unfocusedRounding

  readonly property bool isVertical: orientation == "vertical"

  function getColor() {
    if (insideSpecialWs) {
      return specialWsColor
    }
    else if (isFocused) {
      return focusColor
    }
    else if (isUrgent) {
      return urgentColor
    }
    else {
      return defaultColor
    }
  }

  implicitHeight: itemHeight
  implicitWidth: itemWidth
  radius: {
    if (Config.options.useRounding) {
      if (isFocused) {
        return focusedRounding
      }
      else {
        return unfocusedRounding
      }
    }
    else {
      return 0
    }
  }
  color: getColor()

  useAnimation: Config.options.useAnimation
  animationCurve: Config.styles.animation.curves.standard

  // [DEBUG]: this makes it easy to debug layout issues
  // border {
  //   color: "#dc143c"
  // }
}
