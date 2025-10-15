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

  readonly property real unit: (baseFontSize / fontMetrics.height) * scale

  Component.onCompleted: {
    console.log(fontMetrics.height)
    console.log(unit)
  }

  component FontSize: JsonObject {
    property int extraSmall: 8 * styleConfig.scale
    property int small: 13 * styleConfig.baseFontSize
    property int regular: styleConfig.baseFontSize
    property int large: 21 * styleConfig.scale
    property int extraLarge: 27 * styleConfig.scale

    readonly property real scale: 1.25

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
    // property string sans: "JetBrains Mono"
    property string sans: "Maple Mono"
    // property string sans: "Iosevka Nerd Font Mono"
    property string mono: "Iosevka Nerd Font Mono"
    property string icon: "Symbols Nerd Font"
  }

  component Margin: JsonObject {
    property real extraSmall: 8 * styleConfig.unit
    property real small: 15 * styleConfig.unit
    property real regular: 40 * styleConfig.unit
    property real large: 60 * styleConfig.unit
    property real extraLarge: 100 * styleConfig.unit

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
    property real extraSmall: 7 * styleConfig.unit
    property real small: 15 * styleConfig.unit
    property real regular: 40 * styleConfig.unit
    property real large: 60 * styleConfig.unit
    property real extraLarge: 100 * styleConfig.unit

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
    property real extraSmall: 2
    property real small: 7
    property real regular: 10
    property real large: 18
    property real full: 100

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

  component AnimationCurves: JsonObject {
    property list<real> emphasized: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82, 0.25, 1, 1, 1]
    property list<real> emphasizedAccel: [0.3, 0, 0.8, 0.15, 1, 1]
    property list<real> emphasizedDecel: [0.05, 0.7, 0.1, 1, 1, 1]
    property list<real> standard: [0.2, 0, 0, 1, 1, 1]
    property list<real> standardAccel: [0.3, 0, 1, 1, 1, 1]
    property list<real> standardDecel: [0, 0, 0, 1, 1, 1]
    property list<real> expressiveFastSpatial: [0.42, 1.67, 0.21, 0.9, 1, 1]
    property list<real> expressiveDefaultSpatial: [0.38, 1.21, 0.22, 1, 1, 1]
    property list<real> expressiveEffects: [0.34, 0.8, 0.34, 1, 1, 1]
  }

  component AnimationDurations: JsonObject {
    property int veryFast: 100
    property int fast: 200
    property int normal: 500
    property int slow: 800
    property int verySlow: 1000
  }

  component Animation: JsonObject {
    property AnimationCurves curves: AnimationCurves {}
    property AnimationDurations durations: AnimationDurations {}
  }

  // debug
  // Component.onCompleted: {
  //   console.log(`[INFO] scale: ${scale}`)
  //   console.log(`[INFO] screenDPI: ${Screen.pixelDensity * 25.4}`)
  //   console.log(`[INFO] dpiScale: ${dpiScale}`)
  //   console.log(`[INFO] unit: ${unit}`)
  // }
}
