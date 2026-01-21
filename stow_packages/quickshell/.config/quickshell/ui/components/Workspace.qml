pragma ComponentBehavior: Bound

import QtQuick

import qs.logic.configs
import qs.ui.components.containers

MContainer {
  id: root

  // Individual workspace by itself is not useful, but a group of workspaces
  // can convey needed information, which is why no default property is set,
  // this duty is passed to the WorkspaceList component.
  required property real itemHeight
  required property real itemWidth

  required property color focusColor
  required property color occupiedColor
  required property color inactiveColor
  required property color urgentColor
  required property color specialWsColor

  required property bool isFocused
  required property bool isOccupied
  required property bool isUrgent
  required property bool isSpecialWs

  required property string orientation
  required property real focusedRounding
  required property real occupiedRounding
  required property real inactiveRounding
  // item height and width multiplier
  required property real focusedItemSizeM
  required property real occupiedItemSizeM
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
      return occupiedColor
    }
    else {
      return inactiveColor
    }
  }

  implicitHeight: {
    var value = 1

    if (isVertical) {
      if (isFocused) {
        value = itemHeight * focusedItemSizeM
      }
      else if (isSpecialWs) {
        value = itemHeight * inactiveItemSizeM
      }
      else if (isOccupied || isUrgent) {
        value = itemHeight * occupiedItemSizeM
      }
      else {
        value = itemHeight * inactiveItemSizeM
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
      else if (isSpecialWs) {
        value = itemWidth * inactiveItemSizeM
      }
      else if (isOccupied || isUrgent) {
        value = itemWidth * occupiedItemSizeM
      }
      else {
        value = itemWidth * inactiveItemSizeM
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
        return occupiedRounding
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

  useAnimation: Config.options.useAnimation
  animationDuration: Config.styles.animation.durations.normal
  animationCurve: Config.styles.animation.curves.standard

  // [DEBUG]: this makes it easy to debug layout issues
  // border {
  //   color: "#dc143c"
  // }
}
