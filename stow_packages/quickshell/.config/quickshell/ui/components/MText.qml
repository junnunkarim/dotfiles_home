pragma ComponentBehavior: Bound

import QtQuick

import qs.configs

Text {
  id: textItem

  property string fontFamily: Config.styles.fontFamilies.sans
  property int fontSize: Config.styles.fontSizes.extraSmall
  property int fontWeight: 600
  property string fitMode: "horizontal"
  property bool useAnimation: true
  property int animationDuration: Config.styles.animation.durations.normal

  renderType: Text.NativeRendering
  // renderType: Text.CurveRendering
  // renderType: Text.QtRendering
  // renderTypeQuality: Text.VeryHighRenderTypeQuality
  textFormat: Text.PlainText
  fontSizeMode: fitMode === "fit" ? Text.Fit : (fitMode === "fixed" ? Text.FixedSize : (fitMode === "horizontal" ? Text.HorizontalFit : Text.VerticalFit))

  font.family: fontFamily
  font.weight: fontWeight
  // font.bold: true

  // should scale based on container constraints
  // minimum font size
  minimumPointSize: 1
  // maximum font size
  font.pointSize: fontSize

  // when there isn't enough space, truncate text by adding an ellipsis (...)
  elide: Text.ElideRight
  verticalAlignment: Text.AlignVCenter
  horizontalAlignment: Text.AlignHCenter

  Behavior on text {
    enabled: textItem.useAnimation
    NumberAnimation { 
      target: textItem
      properties: "opacity"
      from: 0.0
      to: 1.0
      duration: textItem.animationDuration
      easing.type: Easing.OutQuad
    }
  }
}
