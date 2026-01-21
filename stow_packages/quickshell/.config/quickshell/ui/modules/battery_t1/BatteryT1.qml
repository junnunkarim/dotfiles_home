pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Io
import Quickshell.Services.UPower

import qs.logic.configs
import qs.ui.components
import qs.ui.components.animations
import qs.ui.components.containers

MContainer {
  id: root

  // pill background container color
  property color pillContColor: "#6e6a86"

  // label colors
  property color textColor: "#9ccfd8"
  property color lowChargeTextColor: "#eb6f92"
  property color chargingTextColor: "#f6c177"

  // main container colors
  property color containerColor: "#214c54"
  property color lowChargeContColor: "#4c3743"
  property color chargingContColor: "#500b1f"

  // pill container colors
  property color normalColor: "#9ccfd8"
  property color lowChargeColor: "#eb6f92"
  property color chargingColor: "#f6c177"

  property real scale: Config.styles.scale

  property int fontSize: isVertical ? Config.styles.fontSizes.sM : Config.styles.fontSizes.sS
  property string fontFamily: Config.styles.fontFamilies.sans
  property FontMetrics fontMetrics: FontMetrics {
    font.family: root.fontFamily
    font.pointSize: Math.round(root.fontSize * root.scale)
  }

  property string orientation: Config.options.orientation
  property bool useRounding: Config.options.useRounding
  property real containerRounding: Config.styles.roundings.sS
  property real pillRounding: Config.styles.roundings.sS

  property bool useAnimation: Config.options.useAnimation
  property int animationDuration: Config.styles.animation.durations.normal

  // no need to multiply "scale" because the calculation is done in fontMetrics
  readonly property int boundHeight: Math.ceil(fontMetrics.height)
  readonly property int boundWidth: fontMetrics.boundingRect("W").width

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
    let horiPadding = Config.styles.paddings.sXXS
    let vertPadding = Config.styles.paddings.sM

    let paddings = isVertical ? vertPadding : horiPadding

    return Math.round(loader.item.implicitHeight + (paddings * scale))
  }
  implicitWidth: {
    let horiPadding = Config.styles.paddings.sL
    let vertPadding = Config.styles.paddings.sL

    let paddings = isVertical ? vertPadding : horiPadding

    return Math.round(loader.item.implicitWidth + (paddings * scale))
  }

  // main container colors
  color: {
    if (root.currentState === "charging" || root.currentState === "fullyCharged") {
      return root.chargingContColor
    }
    else if (root.percentage <= (Config.options.lowChargeThreshold / 100)) {
      return root.lowChargeContColor
    }
    else {
      return root.containerColor
    }
  }

  radius: useRounding ? containerRounding * scale : 0

  IpcHandler {
    target: "battery"
    function setPert(percentage: real): void { root.percentage = percentage }
    function setState(state: string): void { root.currentState = state }
  }

  // components for reusability
  // --------------------------
  //
  // animation components
  component Anim: NumberAnimation {
    duration: root.animationDuration
    easing.type: Easing.OutQuad
  }
  // component ColorAnim: ColorAnimation {
  //   duration: root.animationDuration
  // }

  // battery percentage component
  component BatteryPercent: MTextBox {
    boxHeight: root.boundHeight
    boxWidth: root.boundWidth * 2

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

    fitMode: "fit"

    useAnimation: root.useAnimation
  }

  // battery pill component
  // outer pill container that doesn't change
  component BatteryPill: MContainer {
    // sizes are set in the layout components
    color: root.pillContColor
    radius: root.useRounding ? Math.round(root.pillRounding * root.scale) : 0

    // inner pill container that changes size depending on battery percentage
    MContainer {
      property int spacing: root.boundHeight * 0.1

      // if orientation is horizontal, anchor it to the left of the outer pill
      // container, otherwise anchor it to the bottom
      anchors.top: root.isVertical ? undefined : parent.top
      anchors.right: root.isVertical ? parent.right : undefined

      anchors.left: parent.left
      anchors.bottom: parent.bottom

      // add margins around the inner container
      anchors.margins: spacing

      // if orientation is horizontal, battery percentage will
      // increase/decrease the width of the pill, otherwise it will
      // increase/decrease the height of the pill
      implicitHeight: Math.round(parent.height - (spacing * 2)) * (root.isVertical ? root.percentage : 1)
      implicitWidth: Math.round(parent.width - (spacing * 2)) * (root.isVertical ? 1 : root.percentage)

      color: {
        if (root.currentState === "charging" || root.currentState === "fullyCharged") {
          return root.chargingColor
        }
        else if (root.percentage <= (Config.options.lowChargeThreshold / 100)) {
          return root.lowChargeColor
        }
        else {
          return root.normalColor
        }
      }

      radius: root.useRounding ? root.pillRounding * root.scale : 0

      useAnimation: root.useAnimation
      animationDuration: Config.styles.animation.durations.slow
      animationCurve: Config.styles.animation.curves.expressiveDefaultEffects

      Behavior on color {
        enabled: root.useAnimation
        MColorAnim {}
      }
    }
  }

  // layouts based on orientation
  // ----------------------------
  // horizontal layout
  Component {
    id: horiLayout

    Row {
      anchors.centerIn: parent
      spacing: Config.styles.margins.sXS * root.scale

      BatteryPercent {
        anchors.verticalCenter: parent.verticalCenter

        text: root.percentage * 100
      }

      BatteryPill {
        anchors.verticalCenter: parent.verticalCenter
        implicitHeight: parent.height
        implicitWidth: Math.round(root.boundWidth * 3)
      }
    }
  }

  // vertical layout
  Component {
    id: vertLayout

    Column {
      anchors.centerIn: parent
      spacing: Config.styles.margins.sXXS * root.scale

      BatteryPercent {
        anchors.horizontalCenter: parent.horizontalCenter

        text: root.percentage * 100
      }
      BatteryPill {
        anchors.horizontalCenter: parent.horizontalCenter
        implicitHeight: Math.round(root.boundWidth * 2.5)
        implicitWidth: parent.width
      }
    }
  }

  Loader {
    id: loader

    anchors.centerIn: parent
    sourceComponent: root.isVertical ? vertLayout : horiLayout
  }
}
