pragma ComponentBehavior: Bound

import QtQuick

import qs.logic.configs

Rectangle {
  id: root

  property bool useAnimation: false
  property real animationDuration: Config.styles.animation.durations.normal
  property list<real> animationCurve: Config.styles.animation.curves.expressiveDefaultSpatial

  color: "transparent"

  // [DEBUG]: this makes it easy to debug layout issues
  // border {
  //   color: "#dc143c"
  // }

  component NumAnim: NumberAnimation {
    duration: root.animationDuration
    easing.type: Easing.BezierSpline
    easing.bezierCurve: root.animationCurve
  }

  Behavior on implicitHeight {
    enabled: root.useAnimation
    NumAnim {}
  }
  Behavior on implicitWidth {
    enabled: root.useAnimation
    NumAnim {}
  }
  Behavior on x {
    enabled: root.useAnimation
    NumAnim {}
  }
  Behavior on y {
    enabled: root.useAnimation
    NumAnim {}
  }
}
