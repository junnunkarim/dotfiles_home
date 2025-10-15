pragma ComponentBehavior: Bound

import QtQuick

import qs.configs

Text {
  id: root

  property int fontSize: Config.styles.fontSizes.extraSmall
  property string fontFamily: Config.styles.fontFamilies.sans

  property bool useBold: false
  property int fontWeight: 600

  property string fitMode: "fixed"
  property string orientation: "horizontal"
  property string rotationDirection: "left"

  property bool useAnimation: true
  property int animationDuration: Config.styles.animation.durations.normal

  readonly property bool isVertical: orientation == "vertical"

  renderType: Text.NativeRendering
  textFormat: Text.PlainText
  fontSizeMode: {
    if (fitMode === "fit") {
      return Text.Fit
    }
    else if (fitMode === "fixed") {
      return Text.FixedSize
    }
    else if (fitMode === "horizontal") {
      return Text.HorizontalFit
    }
    else {
      return Text.VerticalFit
    }
  }

  font.family: fontFamily
  font.weight: fontWeight
  font.bold: useBold

  // should scale based on container constraints
  // minimum font size
  minimumPointSize: 1
  // maximum font size
  font.pointSize: fontSize

  // when there isn't enough space, truncate text by adding an ellipsis (...)
  elide: Text.ElideRight
  verticalAlignment: Text.AlignVCenter
  horizontalAlignment: Text.AlignHCenter

  rotation: {
    if (root.isVertical) {
      if (root.rotationDirection === "left") {
        return 90
      }
      else {
        return -90
      }
    }
    else {
      return 0
    }
  }

  Behavior on text {
    enabled: root.useAnimation
    NumberAnimation { 
      target: root
      properties: "opacity"
      from: 0.0
      to: 1.0
      duration: root.animationDuration
      easing.type: Easing.OutQuad
    }
  }
}
