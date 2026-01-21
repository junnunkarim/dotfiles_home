import QtQuick

import qs.logic.configs

ColorAnimation {
  duration: Config.styles.animation.durations.normal
  easing.type: Easing.BezierSpline
  easing.bezierCurve: Config.styles.animation.curves.standard
}
