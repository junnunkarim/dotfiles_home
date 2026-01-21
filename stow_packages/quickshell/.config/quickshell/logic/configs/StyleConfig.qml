pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Io

JsonObject {
  id: styleConfig

  property FontSize fontSizes: FontSize {}
  property FontFamily fontFamilies: FontFamily {}
  property Margin margins: Margin {}
  property Padding paddings: Padding {}
  property Rounding roundings: Rounding {}
  property Transparency transparency: Transparency {}
  property Animation animation: Animation {}

  property real refFontSize: 16
  property FontMetrics fontMetrics: FontMetrics {
    font.family: styleConfig.fontFamilies.sans
    font.pointSize: styleConfig.refFontSize
  }

  property real scale: 1
  property int baseFontSize: 16
  property int baseMargin: 18
  property int basePadding: 18
  property int baseRounding: 2

  readonly property real unit: (baseFontSize / fontMetrics.height)

  Component.onCompleted: {
    console.log(fontMetrics.height)
    console.log(unit)
  }

  component FontSize: JsonObject {
    readonly property real scale: 1.125

    property int sXXXS: Math.round(sXXS / scale)
    property int sXXS: Math.round(sXS / scale)
    property int sXS: Math.round(sS / scale)
    property int sS: Math.round(sM / scale)
    property int sM: styleConfig.baseFontSize
    property int sL: Math.round(sM * scale)
    property int sXL: Math.round(sL * scale)
    property int sXXL: Math.round(sXL * scale)
    property int sXXXL: Math.round(sXXL * scale * 2)
  }

  component FontFamily: JsonObject {
    property string sans: "Iosevka Slab"
    property string mono: "Iosevka"
    property string icon: "Symbols Nerd Font"
  }

  component Margin: JsonObject {
    readonly property real scale: 1.25

    property int sXXXS: Math.round(sXXS / scale / 2)
    property int sXXS: Math.round(sXS / scale)
    property int sXS: Math.round(sS / scale)
    property int sS: Math.round(sM / scale)
    property int sM: Math.round(styleConfig.baseMargin * styleConfig.unit)
    property int sL: Math.round(sM * scale)
    property int sXL: Math.round(sL * scale)
    property int sXXL: Math.round(sXL * scale * 1.5)
    property int sXXXL: Math.round(sXXL * scale * 1.5)
  }

  component Padding: JsonObject {
    readonly property real scale: 1.25

    property int sXXXS: Math.round(sXXS / scale / 2)
    property int sXXS: Math.round(sXS / scale)
    property int sXS: Math.round(sS / scale)
    property int sS: Math.round(sM / scale)
    property int sM: Math.round(styleConfig.basePadding * styleConfig.unit)
    property int sL: Math.round(sM * scale)
    property int sXL: Math.round(sL * scale)
    property int sXXL: Math.round(sXL * scale * 1.5)
    property int sXXXL: Math.round(sXXL * scale * 1.5)
  }

  component Rounding: JsonObject {
    readonly property real scale: 2

    property int sXXS: styleConfig.baseRounding
    property int sXS: Math.round(sXXS * scale)
    property int sS: Math.round(sXS * scale)
    property int sM: Math.round(sS * scale)
    property int sL: Math.round(sM * scale)
    property int sXL: Math.round(sL * scale)
    property int sXXL: 100
  }

  component Transparency: JsonObject {
    property bool enabled: false
    property real base: 0.85
    property real layers: 0.4
  }

  // source: https://m3.material.io/styles/motion/overview/specs
  component AnimationCurves: JsonObject {
    // last points must be 1, 1
    property list<real> emphasized: [
      0.2, 0,
      0, 1,
      1, 1
    ]
    property list<real> emphasizedAccel: [
      0.3, 0,
      0.8, 0.15,
      1, 1
    ]
    property list<real> emphasizedDecel: [
      0.05, 0.7,
      0.1, 1,
      1, 1
    ]
    property list<real> standard: [
      0.2, 0,
      0, 1,
      1, 1
    ]
    property list<real> standardAccel: [
      0.3, 0,
      1, 1,
      1, 1
    ]
    property list<real> standardDecel: [
      0, 0,
      0, 1,
      1, 1
    ]
    property list<real> standardSpatial: [
      0.27, 1.06,
      0.18, 1.00,
      1, 1
    ]
    property list<real> expressiveFastSpatial: [
      0.42, 1.67,
      0.21, 0.9,
      1, 1
    ]
    property list<real> expressiveDefaultSpatial: [
      0.38, 1.21,
      0.22, 1,
      1, 1
    ]
    property list<real> expressiveSlowSpatial: [
      0.39, 1.29,
      0.35, 0.98,
      1, 1
    ]
    property list<real> expressiveFastEffects: [
      0.31, 0.94,
      0.34, 1.00,
      1, 1
    ]
    property list<real> expressiveDefaultEffects: [
      0.34, 0.80,
      0.34, 1.00,
      1, 1
    ]
    property list<real> expressiveSlowEffects: [
      0.34, 0.88,
      0.34, 1.00,
      1, 1
    ]
  }

  component AnimationDurations: JsonObject {
    property int veryFast: 150
    property int fast: 350
    property int normal: 500
    property int slow: 650
    property int verySlow: 750
  }

  component Animation: JsonObject {
    property AnimationCurves curves: AnimationCurves {}
    property AnimationDurations durations: AnimationDurations {}
  }
}
