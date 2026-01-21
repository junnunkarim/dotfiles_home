pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Io

import qs.logic.configs
import qs.logic.services
import qs.ui.components
import qs.ui.components.containers

MContainer {
  id: root

  property real size: Config.styles.fontSizes.sXS
  property real fontSize: size
  property string fontFamily: Config.styles.fontFamilies.sans
  readonly property FontMetrics fontMetrics: FontMetrics {
    font.family: root.fontFamily
    font.pointSize: Math.round(root.size * root.scale)
  }

  property real clientItemHeight: size
  property real clientItemWidth: size

  property color focusColor: "#ebbcba"
  property color unfocusColor: "#908caa"
  property color urgentColor: "#e67e80"
  property color specialWsColor: "#c4a7e7"

  property color labelColor: "#1f1d2e"

  property color outContcolor: "#ebbcba"
  property color inContColor: "#1f1d2e"

  property bool showLabel: true

  property bool useRounding: Config.options.useRounding
  // outer-container rounding
  property real outContRounding: Config.styles.roundings.sXXL
  // in-container rounding
  property real inContRounding: Config.styles.roundings.sXXL
  property real focusedRounding: Config.styles.roundings.sXXL
  property real unfocusedRounding: Config.styles.roundings.sXS
  // container corner radius: bottomLeft, bottomRight, topRight, topLeft
  property list<bool> contCornersToRound: [true, false, false, false]

  // workspace-item height and width multiplier
  property real focusedItemSizeM: 5
  property real unfocusedItemSizeM: 1

  property real scale: Config.styles.scale
  property string orientation: "horizontal"

  // no need to multiply "scale" because the calculation is done in fontMetrics
  readonly property int boundHeight: Math.ceil(fontMetrics.height)
  // find out the maximum width needed to represent a character (only 1 char)
  // with current font size;
  readonly property int boundWidth: fontMetrics.boundingRect("W").width

  readonly property bool isVertical: orientation == "vertical"

  implicitHeight: clientLayoutLoader.item.implicitHeight
  implicitWidth: clientLayoutLoader.item.implicitWidth

  // outer-container corner radius
  bottomLeftRadius: Config.options.useRounding ? (contCornersToRound[0] ? outContRounding : 0) : 0
  bottomRightRadius: Config.options.useRounding ? (contCornersToRound[1] ? outContRounding : 0) : 0
  topRightRadius: Config.options.useRounding ? (contCornersToRound[2] ? outContRounding : 0) : 0
  topLeftRadius: Config.options.useRounding ? (contCornersToRound[3] ? outContRounding : 0) : 0

  color: (!showLabel || isVertical) ? "transparent" : outContcolor

  useAnimation: Config.options.useAnimation

  IpcHandler {
    target: "clientBar"
    function showLabel(): void {
      root.showLabel = !root.showLabel;
    }
  }

  component LabelText: MTextBox {
    property string data: IpcCompositor.compositor.focusedWs?.isOccupied != 0 ? (IpcCompositor.compositor.focusedClient?.title ?? "") : ""
    property int letterLimit: 30

    boxHeight: root.boundHeight
    // we need to set the width in each component
    boxWidth: Math.round(root.boundWidth * (letterLimit + 5))

    fontColor: root.labelColor

    fontSize: Math.round(root.fontSize * root.scale)
    fontFamily: root.fontFamily
    
    fitMode: "fit"
    orientation: root.orientation
    rotationDirection: "right"

    text: data.length > letterLimit ? data.substring(0, letterLimit) : data
  }


  // client-item component
  component ClientItem: Loader {
    id: clientItemLoader

    // get data from Repeater
    required property var modelData
    required property int itemHeight
    required property int itemWidth

    sourceComponent: Component {
      WsClient {
        itemHeight: clientItemLoader.itemHeight
        itemWidth: clientItemLoader.itemWidth

        focusColor: root.focusColor
        unfocusColor: root.unfocusColor
        urgentColor: root.urgentColor
        specialWsColor: root.specialWsColor

        isFocused: clientItemLoader.modelData?.isFocused ?? false
        isUrgent: clientItemLoader.modelData?.isUrgent ?? false
        insideSpecialWs: clientItemLoader.modelData?.insideSpecialWs ?? false

        orientation: root.orientation
        focusedRounding: root.focusedRounding
        unfocusedRounding: root.unfocusedRounding

        focusedItemSizeM: root.focusedItemSizeM
        unfocusedItemSizeM: root.unfocusedItemSizeM
      }
    }
  }

  // horizontal layout of the workspace-bar
  Component {
    id: horiLayout

    Row {
      anchors.centerIn: parent
      spacing: 0

      Loader {
        active: root.showLabel
        visible: active

        sourceComponent: Component {
          MContainer {
            anchors.centerIn: parent

            implicitHeight: clientName.implicitHeight
            implicitWidth: clientName.implicitWidth + (Config.styles.paddings.sXXL * root.scale)

            LabelText {
              id: clientName
              anchors.centerIn: parent
            }
          }
        }
      }

      MContainer {
        id: horiInnerCont

        // children are bound to this implicitHeight
        implicitHeight: root.boundHeight
        // implicitWidth is flowing from the children
        implicitWidth: horiRow.implicitWidth ? Math.round(horiRow.implicitWidth + (Config.styles.paddings.sXXXL * root.scale)) : 0

        // inner-container corner radius
        bottomLeftRadius: Config.options.useRounding ? (root.contCornersToRound[0] ? root.outContRounding : 0) : 0
        bottomRightRadius: Config.options.useRounding ? (root.contCornersToRound[1] ? root.outContRounding : 0) : 0
        topRightRadius: Config.options.useRounding ? (root.contCornersToRound[2] ? root.outContRounding : 0) : 0
        topLeftRadius: Config.options.useRounding ? (root.contCornersToRound[3] ? root.outContRounding : 0) : 0

        color: root.inContColor

        useAnimation: root.useAnimation

        Row {
          id: horiRow

          anchors.centerIn: parent
          spacing: Math.round(Config.styles.margins.sXS * root.scale)

          // clients
          Repeater {
            model: IpcCompositor.compositor.focusedWsClientList
            ClientItem {
              itemHeight: Math.round(horiInnerCont.height * 0.8)
              itemWidth: itemHeight
            }
          }
        }
      }
    }
  }

  // vertical layout of the workspace-bar
  Component {
    id: vertLayout

    MContainer {
      id: vertInnerCont

      implicitHeight: vertColumn.implicitHeight ? Math.round(vertColumn.implicitHeight + (Config.styles.paddings.sXXXL * root.scale)) : 0
      implicitWidth: root.boundHeight

      // inner-container corner radius
      bottomLeftRadius: Config.options.useRounding ? (root.contCornersToRound[0] ? root.outContRounding : 0) : 0
      bottomRightRadius: Config.options.useRounding ? (root.contCornersToRound[1] ? root.outContRounding : 0) : 0
      topRightRadius: Config.options.useRounding ? (root.contCornersToRound[2] ? root.outContRounding : 0) : 0
      topLeftRadius: Config.options.useRounding ? (root.contCornersToRound[3] ? root.outContRounding : 0) : 0

      color: root.inContColor

      useAnimation: root.useAnimation

      Column {
        id: vertColumn

        anchors.centerIn: parent
        spacing: Math.round(Config.styles.margins.sXS * root.scale)

        // clients
        Repeater {
          model: IpcCompositor.compositor.focusedWsClientList
          ClientItem {
            itemHeight: root.boundHeight
            itemWidth: Math.round(vertInnerCont.implicitWidth * 0.8)
          }
        }
      }
    }
  }

  // load horizontal or vertical layout depending on preference
  Loader {
    id: clientLayoutLoader

    // align the inner-container to the left side of the outer-container;
    // need this for label animation
    anchors.right: parent.right

    sourceComponent: root.isVertical ? vertLayout : horiLayout
  }

  // shadow
  MElevation {
    anchors.fill: root
    level: 3
    radius: root.outContRounding
  }
}
