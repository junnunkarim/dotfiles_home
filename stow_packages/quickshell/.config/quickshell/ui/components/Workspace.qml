pragma ComponentBehavior: Bound

import QtQuick

import qs.configs
import qs.ui.components.containers
import qs.ui.components.animations

MContainer {
  id: workspaceItem

  // Individual workspace by itself is not useful, but a group of workspaces
  // can convey needed information, which is why no default property is set,
  // this duty is passed to the WorkspaceList component.
  required property real wsItemHeight
  required property real wsItemWidth

  required property color focusColor
  required property color activeColor
  required property color inactiveColor
  required property color urgentColor
  required property color specialWsColor

  required property bool isFocused
  required property bool isOccupied
  required property bool isUrgent
  required property bool isSpecialWs

  required property string orientation
  required property real focusedRounding
  required property real activeRounding
  required property real inactiveRounding
  // item height and width multiplier
  required property real focusedItemSizeM
  required property real activeItemSizeM
  required property real inactiveItemSizeM

  readonly property bool isVertical: orientation == "vertical"

  function getColor() {
    if (isSpecialWs) {
      return specialWsColor
    }
    else if (isFocused) {
      return focusColor
    }
    else if (isUrgent) {
      return urgentColor
    }
    else if (isOccupied) {
      return activeColor
    }
    else {
      return inactiveColor
    }
  }

  implicitHeight: {
    var value = 1

    if (isVertical) {
      if (isFocused) {
        value = wsItemHeight * focusedItemSizeM
      }
      else if (isSpecialWs) {
        value = wsItemHeight * inactiveItemSizeM
      }
      else if (isOccupied || isUrgent) {
        value = wsItemHeight * activeItemSizeM
      }
      else {
        value = wsItemHeight * inactiveItemSizeM
      }
    }
    else {
      value = wsItemHeight
    }

    return value * Config.styles.unit
  }
  implicitWidth: {
    var value = 1

    if (isVertical) {
      value = wsItemHeight
    }
    else {
      if (isFocused) {
        value = wsItemHeight * focusedItemSizeM
      }
      else if (isSpecialWs) {
        value = wsItemHeight * inactiveItemSizeM
      }
      else if (isOccupied || isUrgent) {
        value = wsItemHeight * activeItemSizeM
      }
      else {
        value = wsItemHeight * inactiveItemSizeM
      }
    }

    return value * Config.styles.unit
  }
  radius: {
    if (Config.options.useRounding) {
      if (isFocused || isSpecialWs) {
        return focusedRounding
      }
      if (isOccupied) {
        return activeRounding
      }
      else {
        return inactiveRounding
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
    MSpringAnimation {}
  }
  Behavior on implicitHeight {
    MSpringAnimation {}
  }
  Behavior on radius {
    MSpringAnimation {}
  }
}
