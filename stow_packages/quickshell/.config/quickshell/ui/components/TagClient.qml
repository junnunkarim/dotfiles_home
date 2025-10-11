pragma ComponentBehavior: Bound

import QtQuick

import qs.configs
import qs.ui.components.containers

MContainer {
  id: tagClient

  required property real boxHeight
  required property real boxWidth
  required property color focusedColor
  required property color unfocusedColor
  required property color urgentColor
  required property string orientation

  required property bool isFocused
  required property bool isUrgent

  property real focusedRounding: Config.styles.roundings.small
  property real unfocusedRounding: Config.styles.roundings.extraSmall
  // height and width multiplier
  property real focusedBoxMulti: 4
  property real unfocusedBoxMulti: 1

  readonly property bool isVertical: orientation == "vertical"

  function getColor() {
    if (isFocused) {
      return focusedColor
    }
    else if (isUrgent) {
      return urgentColor
    }
    else {
      return unfocusedColor
    }
  }

  implicitHeight: {
    var value = 1

    if (isVertical) {
      if (isFocused) {
        value = boxHeight * focusedBoxMulti
      }
      else if (isUrgent) {
        value = boxHeight * unfocusedBoxMulti
      }
      else {
        value = boxHeight * unfocusedBoxMulti
      }
    }
    else {
      value = boxHeight
    }

    return value * Config.styles.unit
  }
  implicitWidth: {
    var value = 1

    if (isVertical) {
      value = boxHeight
    }
    else {
      if (isFocused) {
        value = boxHeight * focusedBoxMulti
      }
      else if (isUrgent) {
        value = boxHeight * unfocusedBoxMulti * 2
      }
      else {
        value = boxHeight * unfocusedBoxMulti
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
        unfocusedRounding
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
}
