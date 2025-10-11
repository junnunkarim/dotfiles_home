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

  property real scale: 1

  component FontSize: JsonObject {
    property int extraSmall: 11 * styleConfig.scale
    property int small: 13 * styleConfig.scale
    property int regular: 17 * styleConfig.scale
    property int large: 21 * styleConfig.scale
    property int extraLarge: 27 * styleConfig.scale
  }

  component FontFamily: JsonObject {
    // property string sans: "JetBrains Mono"
    // property string sans: "Maple Mono"
    property string sans: "Iosevka"
    property string mono: "Iosevka Nerd Font Mono"
    property string icon: "Symbols Nerd Font"
  }

  // aspect ratio logic
  readonly property real smallerDimensionSize: Math.min(Screen.height, Screen.width)
  // dpi logic
  // - manual calculation
  // readonly property real referenceDPI: 128
  // readonly property real screenDPI: Screen.pixelDensity * 25.4
  // readonly property real dpiScale: screenDPI / referenceDPI
  // - automatic
  readonly property real dpiScale: Screen.devicePixelRatio
  // final grid based unit to use everywhere
  readonly property real unit: (smallerDimensionSize / 1080) * dpiScale * scale

  component Margin: JsonObject {
    property real extraSmall: 8 * styleConfig.unit
    property real small: 15 * styleConfig.unit
    property real regular: 40 * styleConfig.unit
    property real large: 60 * styleConfig.unit
    property real extraLarge: 100 * styleConfig.unit
  }

  component Padding: JsonObject {
    property real extraSmall: 8 * styleConfig.unit
    property real small: 15 * styleConfig.unit
    property real regular: 40 * styleConfig.unit
    property real large: 60 * styleConfig.unit
    property real extraLarge: 100 * styleConfig.unit
  }

  component Rounding: JsonObject {
    property real extraSmall: 2
    property real small: 4
    property real regular: 10
    property real large: 18
    property real full: 100
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
    property int extraSmall: 100
    property int small: 200
    property int normal: 500
    property int large: 800
    property int extraLarge: 1000
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
