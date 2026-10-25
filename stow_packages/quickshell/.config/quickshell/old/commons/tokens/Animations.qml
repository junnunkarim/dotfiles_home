import QtQuick

QtObject {
  id: animationTokens

  component CurveDescription: QtObject {
    required property list<real> curve
    required property int durationInMs
  }

  // TODO: add spring animation
  // component SpringDescription: QtObject {}

  // --- bezier curve animations ---
  // -------------------------------
  //
  // source: https://m3.material.io/styles/motion/overview/specs
  // last points must be 1, 1
  readonly property CurveDescription expressiveFastSpatial: CurveDescription {
    curve: [0.42, 1.67, 0.21, 0.90, 1, 1]
    durationInMs: 350
  }

  readonly property CurveDescription expressiveDefaultSpatial: CurveDescription {
    curve: [0.38, 1.21, 0.22, 1.00, 1, 1]
    durationInMs: 500
  }

  readonly property CurveDescription expressiveSlowSpatial: CurveDescription {
    curve: [0.39, 1.29, 0.35, 0.98, 1, 1]
    durationInMs: 650
  }

  readonly property CurveDescription expressiveFastEffects: CurveDescription {
    curve: [0.31, 0.94, 0.34, 1.00, 1, 1]
    durationInMs: 150
  }

  readonly property CurveDescription expressiveDefaultEffects: CurveDescription {
    curve: [0.34, 0.80, 0.34, 1.00, 1, 1]
    durationInMs: 200
  }

  readonly property CurveDescription expressiveSlowEffects: CurveDescription {
    curve: [0.34, 0.88, 0.34, 1.00, 1, 1]
    durationInMs: 300
  }

  readonly property CurveDescription standardFastSpatial: CurveDescription {
    curve: [0.27, 1.06, 0.18, 1.00, 1, 1]
    durationInMs: 350
  }

  readonly property CurveDescription standardDefaultSpatial: CurveDescription {
    curve: [0.27, 1.06, 0.18, 1.00, 1, 1]
    durationInMs: 500
  }

  readonly property CurveDescription standardSlowSpatial: CurveDescription {
    curve: [0.27, 1.06, 0.18, 1.00, 1, 1]
    durationInMs: 750
  }

  readonly property CurveDescription standardFastEffects: CurveDescription {
    curve: [0.31, 0.94, 0.34, 1.00, 1, 1]
    durationInMs: 150
  }

  readonly property CurveDescription standardDefaultEffects: CurveDescription {
    curve: [0.34, 0.80, 0.34, 1.00, 1, 1]
    durationInMs: 200
  }

  readonly property CurveDescription standardSlowEffects: CurveDescription {
    curve: [0.34, 0.88, 0.34, 1.00, 1, 1]
    durationInMs: 300
  }

  readonly property CurveDescription emphasizedAccelerate: CurveDescription {
    curve: [0.30, 0.00, 0.80, 0.15, 1, 1]
    durationInMs: 300
  }

  readonly property CurveDescription emphasizedDecelerate: CurveDescription {
    curve: [0.05, 0.70, 0.10, 0.10, 1, 1]
    durationInMs: 200
  }

  readonly property CurveDescription standardAccelerate: CurveDescription {
    curve: [0.30, 0.00, 0.10, 0.10, 1, 1]
    durationInMs: 300
  }

  readonly property CurveDescription standardDecelerate: CurveDescription {
    curve: [0.00, 0.00, 0.00, 0.10, 1, 1]
    durationInMs: 200
  }
}
