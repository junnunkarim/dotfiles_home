pragma ComponentBehavior: Bound

import QtQuick

import qs.logic.configs
import qs.ui.components.containers

MContainer {
  id: root

  required property real itemHeight
  required property real itemWidth

  required property color focusColor
  required property color unfocusColor
  required property color urgentColor
  required property color specialWsColor

  required property bool isFocused
  required property bool isUrgent
  required property bool insideSpecialWs

  required property string orientation
  required property real focusedRounding
  required property real unfocusedRounding
  // item height and width multiplier
  required property real focusedItemSizeM
  required property real unfocusedItemSizeM

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
      return unfocusColor
    }
  }

  implicitHeight: {
    var value = 1

    if (isVertical) {
      if (isFocused) {
        value = itemHeight * focusedItemSizeM
      }
      else {
        value = itemHeight * unfocusedItemSizeM
      }
    }
    else {
      value = itemHeight
    }

    return value * Config.styles.unit
  }
  implicitWidth: {
    var value = 1

    if (isVertical) {
      value = itemWidth
    }
    else {
      if (isFocused) {
        value = itemWidth * focusedItemSizeM
      }
      else {
        value = itemWidth * unfocusedItemSizeM
      }
    }

    return value * Config.styles.unit
  }
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
