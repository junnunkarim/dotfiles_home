pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

import qs.logic.configs
import qs.logic.services
import qs.ui.components
import qs.ui.components.containers
import qs.ui.modules.ws_bar

MContainer {
  id: root

  property real size: Config.styles.fontSizes.sXS
  property real fontSize: size
  property string fontFamily: Config.styles.fontFamilies.sans
  readonly property FontMetrics fontMetrics: FontMetrics {
    font.family: root.fontFamily
    font.pointSize: Math.round(root.size * root.scale)
  }

  // state colors
  property color focusColor: "#ebbcba"
  property color occupiedColor: "#908caa"
  property color inactiveColor: "#403d52"
  property color urgentColor: "#eb6f92"
  property color specialWsColor: "#c4a7e7"

  // workspace name color
  property color labelColor: "#1f1d2e"

  // container colors
  property color outContcolor: "#ebbcba"
  property color inContColor: "#1f1d2e"

  property bool showLabel: true

  property bool useRounding: Config.options.useRounding
  // outer-container rounding
  property real outContRounding: Config.styles.roundings.sXXL
  // in-container rounding
  property real inContRounding: Config.styles.roundings.sXXL
  property real focusedRounding: Config.styles.roundings.sXXL
  property real occupiedRounding: Config.styles.roundings.sS
  property real inactiveRounding: Config.styles.roundings.sXS
  // container corner radius: bottomLeft, bottomRight, topRight, topLeft
  property list<bool> contCornersToRound: [false, true, false, false]

  // workspace-item height and width multiplier
  property real focusedItemSizeM: 7
  property real occupiedItemSizeM: 3
  property real inactiveItemSizeM: 1

  property real scale: Config.styles.scale
  property string orientation: Config.options.orientation


  // no need to multiply "scale" because the calculation is done in fontMetrics
  readonly property int boundHeight: Math.ceil(fontMetrics.height)
  // find out the maximum width needed to represent a character (only 1 char)
  // with current font size;
  readonly property int boundWidth: fontMetrics.boundingRect("W").width

  readonly property bool isVertical: orientation === "vertical"

  implicitHeight: layoutLoader.item.implicitHeight
  implicitWidth: layoutLoader.item.implicitWidth

  // outer-container corner radius
  bottomLeftRadius: Config.options.useRounding ? (contCornersToRound[0] ? outContRounding : 0) : 0
  bottomRightRadius: Config.options.useRounding ? (contCornersToRound[1] ? outContRounding : 0) : 0
  topRightRadius: Config.options.useRounding ? (contCornersToRound[2] ? outContRounding : 0) : 0
  topLeftRadius: Config.options.useRounding ? (contCornersToRound[3] ? outContRounding : 0) : 0

  color: (!showLabel || isVertical) ? "transparent" : outContcolor

  useAnimation: Config.options.useAnimation

  IpcHandler {
    target: "workspace"
    function showLabel(): void { root.showLabel = !root.showLabel; }
  }

  component LabelText: MTextBox {
    property string data: IpcCompositor.compositor.focusedWs?.name ?? ""

    boxHeight: root.boundHeight
    // we need to set the width in each component
    boxWidth: root.boundWidth * 10

    fontColor: root.labelColor

    fontSize: Math.round(root.fontSize * root.scale)
    fontFamily: root.fontFamily
    
    fitMode: "fit"
    orientation: root.orientation
    rotationDirection: "right"

    text: data
  }

  // workspace-item component
  component WsItem: Loader {
    id: wsItemLoader

    // get data from Repeater
    required property var modelData
    required property int itemHeight
    required property int itemWidth

    // to check if we should show inactive workspaces depending on the
    // "showInactiveWs" option
    active: {
      if (Config.options.showInactiveWs || modelData.isFocused) {
        return true
      }
      else {
        // if there are no toplevel in a workspace, return false;
        // effectively not showing inactive workspaces
        return (modelData?.isOccupied ?? false)
      }
    }
    visible: active

    sourceComponent: Component {
      Workspace {
        itemHeight: wsItemLoader.itemHeight
        itemWidth: wsItemLoader.itemWidth

        focusColor: root.focusColor
        occupiedColor: root.occupiedColor
        inactiveColor: root.inactiveColor
        urgentColor: root.urgentColor
        specialWsColor: root.specialWsColor

        isFocused: wsItemLoader.modelData?.isFocused ?? false
        isOccupied: wsItemLoader.modelData?.isOccupied ?? false
        isUrgent: wsItemLoader.modelData?.isUrgent ?? false
        isSpecialWs: wsItemLoader.modelData?.isSpecialWs ?? false

        orientation: root.orientation
        focusedRounding: root.focusedRounding
        occupiedRounding: root.occupiedRounding
        inactiveRounding: root.inactiveRounding

        focusedItemSizeM: root.focusedItemSizeM
        occupiedItemSizeM: root.occupiedItemSizeM
        inactiveItemSizeM: root.inactiveItemSizeM
      }
    }
  }

  // horizontal layout of the workspace-bar
  Component {
    id: horiLayout

    Row {
      anchors.centerIn: parent
      spacing: 0

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

          // [ISSUE]: if there are special workspaces and quickshell is
          // reloaded, then those special workspaces doesn't show up
          // but they do show up if "add" animation is disabled
          // add: Transition {
          //   WsAnim {}
          // }

          // normal workspaces
          Repeater {
            model: IpcCompositor.compositor.wsList
            // model: ScriptModel {
            //   values: IpcCompositor.compositor.wsList
            // }
            delegate: wsItemComp
            WsItem {
              itemHeight: Math.round(horiInnerCont.height * 0.8)
              itemWidth: itemHeight
            }
          }

          // scratch/special workspaces
          Repeater {
            model: IpcCompositor.compositor.specialWsList
            // delegate: wsItemComp
            WsItem {
              itemHeight: Math.round(horiInnerCont.height * 0.8)
              itemWidth: itemHeight
            }
          }
        }
      }

      Loader {
        active: root.showLabel
        visible: active

        sourceComponent: Component {
          MContainer {
            anchors.centerIn: parent

            implicitHeight: wsName.implicitHeight
            implicitWidth: wsName.implicitWidth + (Config.styles.paddings.sXXL * root.scale)

            LabelText {
              id: wsName
              anchors.centerIn: parent
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

        // normal workspaces
        Repeater {
          model: IpcCompositor.compositor.wsList
          // delegate: wsItemComp
          WsItem {
            itemHeight: root.boundHeight
            itemWidth: Math.round(vertInnerCont.implicitWidth * 0.8)
          }
        }

        // scratch/special workspaces
        Repeater {
          model: IpcCompositor.compositor.specialWsList
          // delegate: wsItemComp
          WsItem {
            itemHeight: itemWidth
            itemWidth: Math.round(vertInnerCont.implicitWidth * 0.8)
          }
        }
      }
    }
  }

  // load horizontal or vertical layout depending on preference
  Loader {
    id: layoutLoader

    // align the inner-container to the left side of the outer-container;
    // need this for label animation
    anchors.left: parent.left

    sourceComponent: root.isVertical ? vertLayout : horiLayout
  }

  // shadow
  MElevation {
    anchors.fill: root
    level: 3
    radius: root.outContRounding
  }
}
