pragma ComponentBehavior: Bound

import QtQuick

import qs.configs
import qs.ui.components.containers
import qs.ui.components.animations

MContainer {
  id: clientItem

  required property real clientItemHeight
  required property real clientItemWidth

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
        value = clientItemHeight * focusedItemSizeM
      }
      else {
        value = clientItemHeight * unfocusedItemSizeM
      }
    }
    else {
      value = clientItemHeight
    }

    return value * Config.styles.unit
  }
  implicitWidth: {
    var value = 1

    if (isVertical) {
      value = clientItemHeight
    }
    else {
      if (isFocused) {
        value = clientItemHeight * focusedItemSizeM
      }
      else {
        value = clientItemHeight * unfocusedItemSizeM
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

  // [DEBUG]: this makes it easy to debug layout issues
  // border {
  //   color: "#dc143c"
  // }

  Behavior on implicitWidth {
    MSmoothAnimation {}
  }
  Behavior on implicitHeight {
    MSmoothAnimation {}
  }
  Behavior on radius {
    MSmoothAnimation {}
  }
}
