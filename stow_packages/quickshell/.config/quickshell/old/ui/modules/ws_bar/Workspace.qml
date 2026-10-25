pragma ComponentBehavior: Bound

import QtQuick

import qs.logic.configs
import qs.ui.components.containers

MContainer {
  id: root

  // required properties
  required property color baseColor
  required property color specialWsColor
  required property color occupiedColor
  required property color focusColor
  required property color urgentColor
  required property color hoverColor

  required property bool isSpecialWs
  required property bool isOccupied
  required property bool isFocused
  required property bool isUrgent

  required property real baseRounding
  required property real occupiedRounding
  required property real focusedRounding

  required property bool useRounding

  // state properties
  property bool isHovered: false

  // other properties
  useAnimation: Config.options.useAnimation

  radius: {
    switch(true) {
    case root.useRounding:
      switch(true) {
      case root.isFocused:
      case root.isSpecialWs:
        return focusedRounding
      case isOccupied:
        return occupiedRounding
      default:
        return baseRounding
      }
    default:
      return 0
    }
  }

  color: {
    switch(true) {
    case root.isHovered:
      return root.hoverColor
    case root.isUrgent:
      return root.urgentColor
    case root.isFocused:
      return root.focusColor
    case root.isSpecialWs:
      return root.specialWsColor
    case root.isOccupied:
      return root.occupiedColor
    default:
      return root.baseColor
    }
  }

  MouseArea {
    anchors.fill: root

    hoverEnabled: true

    onEntered: () => { parent.isHovered = true }
    onExited: () => { parent.isHovered = false }
  }
}
