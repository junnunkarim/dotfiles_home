pragma ComponentBehavior: Bound

import QtQuick

import qs.configs

Text {
  id: textItem

  property string fontFamily: Config.styles.fontFamilies.sans
  property int fontSize: Config.styles.fontSizes.extraSmall
  property int fontWeight: 600
  property bool animation: false
  property string animationProperty: "scale"
  property real animationFrom: 0
  property real animationTo: 1
  property int animationDuration: Config.styles.animation.durations.normal

  // renderType: Text.CurveRendering
  renderType: Text.NativeRendering
  textFormat: Text.PlainText
  fontSizeMode: Text.Fit

  font.family: fontFamily
  font.pointSize: fontSize
  font.weight: fontWeight

  // when there isn't enough space, truncate text by adding an ellipsis (...)
  // elide: Text.ElideRight
  verticalAlignment: Text.AlignVCenter
  horizontalAlignment: Text.AlignHCenter

  // Behavior on text {
  //   NumberAnimation { 
  //     target: textItem
  //     properties: "opacity,scale"
  //     from: 0.0
  //     to: 1.0
  //     duration: 400
  //     easing.type: Easing.OutQuad
  //   }
  // }
}
