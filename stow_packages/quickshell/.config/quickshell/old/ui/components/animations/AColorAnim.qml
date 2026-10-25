import QtQuick

import qs.configs

ColorAnimation {
  duration: Config.styles.animation.durations.slow
  easing.type: Easing.BezierSpline
  easing.bezierCurve: Config.styles.animation.curves.emphasized
}
