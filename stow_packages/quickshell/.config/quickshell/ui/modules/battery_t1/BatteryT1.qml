pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Io
import Quickshell.Services.UPower

import qs.configs
import qs.ui.components
import qs.ui.components.containers

MContainer {
  id: root

  // pill background container color
  property color pillContColor: "#7a8478"

  // label colors
  property color textColor: "#a7c080"
  property color lowChargeTextColor: "#e67e80"
  property color chargingTextColor: "#dbbc7f"

  // main container colors
  property color containerColor: "#3c4841"
  property color lowChargeContColor: "#4c3743"
  property color chargingContColor: "#45443c"

  // pill container colors
  property color normalColor: "#a7c080"
  property color lowChargeColor: "#e67e80"
  property color chargingColor: "#dbbc7f"

  property real scale: 1
  property real boxSize: isVertical ? 28 : 22
  property int fontSize: Config.styles.fontSizes.regular
  property string fontFamily: Config.styles.fontFamilies.sans

  property string orientation: Config.options.orientation
  property real containerRounding: Config.styles.roundings.regular
  property real pillRounding: Config.styles.roundings.small

  property bool useAnimation: Config.options.useAnimation
  property int animationDuration: Config.styles.animation.durations.normal

  readonly property bool isVertical: orientation === "vertical"

  // battery percentage range is 0.0 - 1.0
  property real percentage: UPower.displayDevice?.percentage ?? 0
  // current state of battery
  property string currentState: {
    let upowerState = UPower.displayDevice.state

    if (upowerState === UPowerDeviceState.FullyCharged) {
      return "fullyCharged"
    }
    else if (upowerState === UPowerDeviceState.Charging) {
      return "charging"
    }
    else {
      return "discharging"
    }
  }

  // main container size
  implicitHeight: {
    let horiPadding = Config.styles.paddings.extraSmall
    let vertPadding = Config.styles.paddings.small

    let paddings = isVertical ? vertPadding : horiPadding

    return Math.round(loader.item.implicitHeight + paddings * scale)
  }
  implicitWidth: {
    let horiPadding = Config.styles.paddings.small
    let vertPadding = Config.styles.paddings.extraSmall

    let paddings = isVertical ? vertPadding : horiPadding

    return Math.round(loader.item.implicitWidth + paddings * scale)
  }

  // main container colors
  Gradient {
    id: contGradient
    orientation: Gradient.Horizontal

    GradientStop { position: 0.0; color: root.chargingContColor }
    GradientStop { position: 0.7; color: root.containerColor }
  }
  color: {
    if (root.currentState === "charging") {
      return root.chargingContColor
    }
    else if (root.percentage <= (Config.options.lowChargeThreshold / 100)) {
      return root.lowChargeContColor
    }
    else {
      return root.containerColor
    }
  }
  gradient: root.currentState === "fullyCharged" ? contGradient : undefined

  radius: containerRounding

  IpcHandler {
    target: "battery"
    function setPert(percentage: real): void { root.percentage = percentage }
    function setState(state: string): void { root.currentState = state }
  }

  // components for reusability
  // --------------------------
  // animation components
  component Anim: NumberAnimation {
    duration: root.animationDuration
    easing.type: Easing.OutQuad
  }
  component ColorAnim: ColorAnimation {
    duration: root.animationDuration
  }

  // battery percentage component
  component BatteryPercent: MTextBox {
    boxHeight: Math.round(root.boxSize * root.scale * Config.styles.unit)
    boxWidth: Math.round(root.boxSize * root.scale * Config.styles.unit)

    fgColor: {
      if (root.currentState === "charging" || root.currentState === "fullyCharged") {
        return root.chargingTextColor
      }
      else if (root.percentage <= (Config.options.lowChargeThreshold / 100)) {
        return root.lowChargeTextColor
      }
      else {
        return root.textColor
      }
    }

    fontSize: Math.round(root.fontSize * root.scale)
    fontFamily: root.fontFamily

    fitMode: root.isVertical ? "horizontal" : "horizontal"

    useAnimation: root.useAnimation
  }

  // battery pill component
  // outer pill container that doesn't change
  component BatteryPill: MContainer {
    // sizes are set in the layout components
    color: root.pillContColor
    radius: Math.round(root.pillRounding * root.scale)

    useAnimation: root.useAnimation

    // inner pill container that changes size depending on battery percentage
    MContainer {
      property int spacing: root.boxSize * 0.1

      // anchor it to the left of the outer pill container and add margins
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.bottom: parent.bottom
      anchors.margins: spacing

      implicitHeight: Math.round(parent.height - (spacing * 2))
      // battery percentage will increase/decrease the width of the pill
      implicitWidth: Math.round((parent.width - (spacing * 2)) * root.percentage)

      Gradient {
        id: pillGradient
        orientation: Gradient.Horizontal

        GradientStop { position: 0.0; color: root.chargingColor }
        GradientStop { position: 0.7; color: root.normalColor }
      }
      color: {
        if (root.currentState === "charging") {
          return root.chargingColor
        }
        else if (root.percentage <= (Config.options.lowChargeThreshold / 100)) {
          return root.lowChargeColor
        }
        else {
          return root.normalColor
        }
      }
      gradient: root.currentState === "fullyCharged" ? pillGradient : undefined

      radius: root.pillRounding * root.scale

      useAnimation: root.useAnimation

      // animations
      Behavior on implicitWidth {
        enabled: root.useAnimation
        Anim {}
      }
      Behavior on implicitHeight {
        enabled: root.useAnimation
        Anim {}
      }
      Behavior on color {
        enabled: root.useAnimation
        ColorAnim {}
      }
    }
  }

  // layouts based on orientation
  // ----------------------------
  // horizontal layout
  Component {
    id: horiLayout

    Row {
      spacing: Math.round(root.boxSize * 0.3)

      BatteryPercent {
        anchors.verticalCenter: parent.verticalCenter

        text: root.percentage * 100
      }

      BatteryPill {
        anchors.verticalCenter: parent.verticalCenter

        implicitHeight: Math.round(root.boxSize * root.scale * Config.styles.unit)
        implicitWidth: Math.round((root.boxSize * 1.5) * root.scale * Config.styles.unit)
      }
    }
  }

  // vertical layout
  Component {
    id: vertLayout

    Column {
      spacing: Math.round(root.boxSize * 0.3)

      BatteryPercent {
        anchors.horizontalCenter: parent.horizontalCenter
        boxHeight: Math.round((root.boxSize * 0.8) * root.scale * Config.styles.unit)

        text: root.percentage * 100
      }
      BatteryPill {
        anchors.horizontalCenter: parent.horizontalCenter

        implicitHeight: Math.round((root.boxSize * 0.7) * root.scale * Config.styles.unit)
        implicitWidth: Math.round(root.boxSize * root.scale * Config.styles.unit)
      }
    }
  }

  Loader {
    id: loader

    anchors.centerIn: parent
    sourceComponent: root.isVertical ? vertLayout : horiLayout
  }
}
