import QtQuick
import QtQuick.Effects

// taken and adapted from caelestia shell:
// https://github.com/caelestia-dots/shell/blob/4cb1048fdd6fa281baa0efa36c8c82ddd2cc43a3/components/effects/Elevation.qml
RectangularShadow {
  property int level
  // source: https://m3.material.io/styles/elevation/tokens
  property real dp: [0, 1, 3, 6, 8, 12][level]

  z: -1
  color: Qt.alpha("#272e33", 0.7)
  blur: (dp * 5) ** 0.7
  spread: -dp * 0.3 + (dp * 0.1) ** 2
  offset.y: dp / 2

  Behavior on dp {
    NumberAnimation {
      duration: Config.styles.animation.durations.normal
      easing.type: Easing.BezierSpline
      easing.bezierCurve: Config.styles.animation.curves.standard
    }
  }
}
