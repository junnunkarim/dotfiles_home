pragma ComponentBehavior: Bound

import QtQuick

import qs.commons.tokens
import qs.ui.components.animations

Rectangle {
  id: root

  property bool useAnimation: false
  property real animationDuration: StyleTokens.animations.expressiveDefaultSpatial.durationInMs
  property list<real> animationCurve: StyleTokens.animations.expressiveDefaultSpatial.curve

  color: "transparent"

  // DEBUG: this makes it easy to debug layout issues
  // border {
  //   color: "#dc143c"
  // }

  component ANumAnim: NumberAnimation {
    duration: root.animationDuration
    easing.type: Easing.BezierSpline
    easing.bezierCurve: root.animationCurve
  }

  Behavior on height {
    enabled: root.useAnimation
    ANumAnim {}
  }
  Behavior on width {
    enabled: root.useAnimation
    ANumAnim {}
  }

  Behavior on implicitHeight {
    enabled: root.useAnimation
    ANumAnim {}
  }
  Behavior on implicitWidth {
    enabled: root.useAnimation
    ANumAnim {}
  }

  Behavior on radius {
    enabled: root.useAnimation
    ANumAnim {}
  }

  Behavior on color {
    enabled: root.useAnimation
    AColorAnim {}
  }
}
