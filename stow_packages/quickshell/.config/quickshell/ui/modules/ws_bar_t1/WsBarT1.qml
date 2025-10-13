pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Io

import qs.configs
import qs.services
import qs.ui.components
import qs.ui.components.animations
import qs.ui.components.containers

MContainer {
  id: root

  property real wsItemHeight: 9
  property real wsItemWidth: 10

  // state colors
  property color focusColor: "#a7c080"
  property color activeColor: "#859289"
  property color inactiveColor: "#4f5b58"
  property color urgentColor: "#e67e80"
  property color specialWsColor: "#d699b6"

  // workspace name color
  property color wsLabelColor: "#272e33"

  // container colors
  property color outContcolor: "#9da9a0"
  property color inContColor: "#272e33"

  property real labelFontSize: Config.styles.fontSizes.small
  property string labelFontFamily: Config.styles.fontFamilies.sans

  property string orientation: "horizontal"
  property bool showWsLabel: true

  // outer-container rounding
  property real outContRounding: Config.styles.roundings.full
  // in-container rounding
  property real inContRounding: Config.styles.roundings.full
  property real focusedRounding: Config.styles.roundings.full
  property real activeRounding: Config.styles.roundings.small
  property real inactiveRounding: Config.styles.roundings.extraSmall
  // container corner radius: bottomLeft, bottomRight, topRight, topLeft
  property list<bool> contCornersToRound: [false, true, false, false]

  // workspace-item height and width multiplier
  property real focusedItemSizeM: 7
  property real activeItemSizeM: 3
  property real inactiveItemSizeM: 1

  readonly property bool isVertical: orientation == "vertical"

  implicitHeight: wsLayoutLoader.item.implicitHeight
  implicitWidth: wsLayoutLoader.item.implicitWidth

  // outer-container corner radius
  bottomLeftRadius: Config.options.useRounding ? (contCornersToRound[0] ? outContRounding : 0) : 0
  bottomRightRadius: Config.options.useRounding ? (contCornersToRound[1] ? outContRounding : 0) : 0
  topRightRadius: Config.options.useRounding ? (contCornersToRound[2] ? outContRounding : 0) : 0
  topLeftRadius: Config.options.useRounding ? (contCornersToRound[3] ? outContRounding : 0) : 0

  color: outContcolor

  useAnimation: Config.options.useAnimation

  IpcHandler {
    target: "wsBar"
    function showLabel(): void { root.showWsLabel = !root.showWsLabel; }
  }

  // workspace-item component
  Component {
    id: wsItemComp

    Loader {
      id: wsItemLoader

      // get data from Repeater
      required property var modelData

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
          wsItemHeight: root.wsItemHeight
          wsItemWidth: root.wsItemWidth

          focusColor: root.focusColor
          activeColor: root.activeColor
          inactiveColor: root.inactiveColor
          urgentColor: root.urgentColor
          specialWsColor: root.specialWsColor

          isFocused: wsItemLoader.modelData?.isFocused ?? false
          isOccupied: wsItemLoader.modelData?.isOccupied ?? false
          isUrgent: wsItemLoader.modelData?.isUrgent ?? false
          isSpecialWs: wsItemLoader.modelData?.isSpecialWs ?? false

          orientation: root.orientation
          focusedRounding: root.focusedRounding
          activeRounding: root.activeRounding
          inactiveRounding: root.inactiveRounding

          focusedItemSizeM: root.focusedItemSizeM
          activeItemSizeM: root.activeItemSizeM
          inactiveItemSizeM: root.inactiveItemSizeM
        }
      }
    }
  }

  // horizontal layout of the workspace-bar
  Component {
    id: horiWsLayout

    Row {
      id: horiWsContainer

      anchors.centerIn: parent
      spacing: 0

      MContainer {
        id: horiWsInnerCon

        implicitHeight: horiWsRow.implicitHeight ? horiWsRow.implicitHeight + Config.styles.paddings.extraSmall : 0
        implicitWidth: horiWsRow.implicitWidth ? horiWsRow.implicitWidth + Config.styles.paddings.large : 0

        // inner-container corner radius
        bottomLeftRadius: Config.options.useRounding ? (root.contCornersToRound[0] ? root.outContRounding : 0) : 0
        bottomRightRadius: Config.options.useRounding ? (root.contCornersToRound[1] ? root.outContRounding : 0) : 0
        topRightRadius: Config.options.useRounding ? (root.contCornersToRound[2] ? root.outContRounding : 0) : 0
        topLeftRadius: Config.options.useRounding ? (root.contCornersToRound[3] ? root.outContRounding : 0) : 0

        color: root.inContColor

        useAnimation: true

        Row {
          id: horiWsRow

          anchors.centerIn: parent
          spacing: Config.styles.margins.extraSmall

          // [ISSUE]: if there are special workspaces and quickshell is
          // reloaded, then those special workspaces doesn't show up
          // but they do show up if "add" animation is disabled
          add: Transition {
            ParallelAnimation {
              NumberAnimation { 
                properties: "opacity"
                from: 0.0
                to: 1.0
                duration: 300
                easing.type: Easing.OutQuad
              }
              NumberAnimation { 
                properties: "scale"
                from: 0
                to: 1
                duration: 300
                easing.type: Easing.OutQuad
              }
            }
          }

          // normal workspaces
          Repeater {
            model: IpcCompositor.compositor.wsList
            delegate: wsItemComp
          }

          // scratch/special workspaces
          Repeater {
            model: IpcCompositor.compositor.specialWsList
            delegate: wsItemComp
          }
        }

        Behavior on implicitHeight {
          enabled: root.useAnimation
          MSpringAnimation {}
        }
        Behavior on implicitWidth {
          enabled: root.useAnimation
          MSpringAnimation {}
        }
      }

      Loader {
        active: root.showWsLabel
        visible: active

        sourceComponent: Component {
          MContainer {
            anchors.centerIn: parent

            implicitHeight: wsName.implicitHeight
            implicitWidth: wsName.implicitWidth + Config.styles.paddings.small

            MTextBox {
              id: wsName

              anchors.centerIn: parent

              boxHeight: horiWsInnerCon.implicitHeight
              boxWidth: root.wsItemWidth * 10

              fgColor: root.wsLabelColor

              fontSize: root.labelFontSize
              fontFamily: root.labelFontFamily
              fitMode: "vertical"
              orientation: "horizontal"

              text: IpcCompositor.compositor.focusedWs?.name ?? ""
            }
          }
        }
      }
    }
  }

  // vertical layout of the workspace-bar
  Component {
    id: vertWsLayout

    Column {
      id: vertWsContainer

      anchors.centerIn: parent
      spacing: 0

      MContainer {
        id: vertWsInnerCon

        implicitHeight: vertWsColumn.implicitHeight ? vertWsColumn.implicitHeight + Config.styles.margins.large : 0
        implicitWidth: vertWsColumn.implicitWidth ? vertWsColumn.implicitWidth + Config.styles.margins.extraSmall : 0

        // inner-container corner radius
        bottomLeftRadius: Config.options.useRounding ? (root.contCornersToRound[0] ? root.outContRounding : 0) : 0
        bottomRightRadius: Config.options.useRounding ? (root.contCornersToRound[1] ? root.outContRounding : 0) : 0
        topRightRadius: Config.options.useRounding ? (root.contCornersToRound[2] ? root.outContRounding : 0) : 0
        topLeftRadius: Config.options.useRounding ? (root.contCornersToRound[3] ? root.outContRounding : 0) : 0

        color: root.inContColor

        useAnimation: true

        Column {
          id: vertWsColumn

          anchors.centerIn: parent
          spacing: Config.styles.margins.extraSmall

          // [ISSUE]: if there are special workspaces and quickshell is
          // reloaded, then those special workspaces doesn't show up
          // but they do show up if "add" animation is disabled
          add: Transition {
            ParallelAnimation {
              NumberAnimation { 
                properties: "opacity"
                from: 0.0
                to: 1.0
                duration: 300
                easing.type: Easing.OutQuad
              }
              NumberAnimation { 
                properties: "scale"
                from: 0
                to: 1
                duration: 300
                easing.type: Easing.OutQuad
              }
            }
          }

          // normal workspaces
          Repeater {
            model: IpcCompositor.compositor.wsList
            delegate: wsItemComp
          }

          // scratch/special workspaces
          Repeater {
            model: IpcCompositor.compositor.specialWsList
            delegate: wsItemComp
          }
        }

        Behavior on implicitHeight {
          enabled: root.useAnimation
          MSpringAnimation {}
        }
        Behavior on implicitWidth {
          enabled: root.useAnimation
          MSpringAnimation {}
        }
      }

      Loader {
        active: root.showWsLabel
        visible: active

        sourceComponent: Component {
          MContainer {
            anchors.centerIn: parent

            implicitHeight: wsName.implicitHeight + Config.styles.margins.regular
            implicitWidth: wsName.implicitWidth

            MTextBox {
              id: wsName

              anchors.centerIn: parent

              boxHeight: root.wsItemHeight * 10
              boxWidth: vertWsInnerCon.implicitWidth

              fgColor: root.wsLabelColor

              fontSize: root.labelFontSize
              fontFamily: root.labelFontFamily
              fitMode: "vertical"
              orientation: "vertical"

              text: IpcCompositor.compositor.focusedWs?.name ?? ""
            }
          }
        }
      }
    }
  }

  // load horizontal or vertical layout depending on preference
  Loader {
    id: wsLayoutLoader

    // align the inner-container to the left side of the outer-container;
    // need this for label animation
    anchors.left: parent.left

    sourceComponent: root.isVertical ? vertWsLayout : horiWsLayout
  }


  Behavior on implicitHeight {
    enabled: root.useAnimation
    MSpringAnimation {}
  }
  Behavior on implicitWidth {
    enabled: root.useAnimation
    MSpringAnimation {}
  }
}
