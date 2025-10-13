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

  property real clientItemHeight: 9
  property real clientItemWidth: 10

  property color focusColor: "#7fbbb3"
  property color unfocusColor: "#859289"
  property color urgentColor: "#e67e80"
  property color specialWsColor: "#d699b6"

  property color clientLabelColor: "#272e33"
  property color outContcolor: "#9da9a0"
  property color inContColor: "#272e33"

  property real labelFontSize: Config.styles.fontSizes.small
  property string labelFontFamily: Config.styles.fontFamilies.sans

  property string orientation: "horizontal"
  property bool showClientLabel: true

  // outer-container rounding
  property real outContRounding: Config.styles.roundings.full
  // in-container rounding
  property real inContRounding: Config.styles.roundings.full

  property real focusedRounding: Config.styles.roundings.full
  property real unfocusedRounding: Config.styles.roundings.small
  // container corner radius: bottomLeft, bottomRight, topRight, topLeft
  property list<bool> contCornersToRound: [true, false, false, false]

  // workspace-item height and width multiplier
  property real focusedItemSizeM: 5
  property real unfocusedItemSizeM: 1

  readonly property bool isVertical: orientation == "vertical"

  implicitHeight: clientLayoutLoader.item.implicitHeight
  implicitWidth: clientLayoutLoader.item.implicitWidth

  // outer-container corner radius
  bottomLeftRadius: Config.options.useRounding ? (contCornersToRound[0] ? outContRounding : 0) : 0
  bottomRightRadius: Config.options.useRounding ? (contCornersToRound[1] ? outContRounding : 0) : 0
  topRightRadius: Config.options.useRounding ? (contCornersToRound[2] ? outContRounding : 0) : 0
  topLeftRadius: Config.options.useRounding ? (contCornersToRound[3] ? outContRounding : 0) : 0

  color: outContcolor

  useAnimation: true

  IpcHandler {
    target: "clientBar"
    function showLabel(): void {
      root.showClientLabel = !root.showClientLabel;
    }
  }

  // client-item component
  Component {
    id: clientItemComp

    Loader {
      id: clientItemLoader

      // get data from Repeater
      required property var modelData

      // active: true
      // visible: active

      sourceComponent: Component {
        WsClient {
          anchors.verticalCenter: parent.verticalCenter
          clientItemHeight: root.clientItemHeight
          clientItemWidth: root.clientItemWidth

          focusColor: root.focusColor
          unfocusColor: root.unfocusColor
          urgentColor: root.urgentColor
          specialWsColor: root.specialWsColor

          isFocused: clientItemLoader.modelData?.isActive ?? false
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
  }

  // horizontal layout of the workspace-bar
  Component {
    id: horiClientLayout

    Row {
      anchors.centerIn: parent
      spacing: 0

      Loader {
        active: root.showClientLabel
        visible: active

        sourceComponent: Component {
          MContainer {
            anchors.centerIn: parent

            implicitHeight: clientName.implicitHeight
            implicitWidth: clientName.implicitWidth + Config.styles.paddings.large

            MTextBox {
              id: clientName

              anchors.centerIn: parent

              boxHeight: horiClientInnerCon.implicitHeight
              boxWidth: Math.round(root.clientItemWidth * 20)

              fgColor: root.clientLabelColor

              fontSize: root.labelFontSize
              fontFamily: root.labelFontFamily
              fitMode: "vertical"
              orientation: "horizontal"

              text: IpcCompositor.compositor.focusedClient?.title ?? ""
            }
          }
        }
      }

      MContainer {
        id: horiClientInnerCon

        implicitHeight: horiClientRow.implicitHeight ? horiClientRow.implicitHeight + Config.styles.paddings.extraSmall : 0
        implicitWidth: horiClientRow.implicitWidth ? horiClientRow.implicitWidth + Config.styles.paddings.large : 0

        // inner-container corner radius
        bottomLeftRadius: Config.options.useRounding ? (root.contCornersToRound[0] ? root.outContRounding : 0) : 0
        bottomRightRadius: Config.options.useRounding ? (root.contCornersToRound[1] ? root.outContRounding : 0) : 0
        topRightRadius: Config.options.useRounding ? (root.contCornersToRound[2] ? root.outContRounding : 0) : 0
        topLeftRadius: Config.options.useRounding ? (root.contCornersToRound[3] ? root.outContRounding : 0) : 0

        color: root.inContColor

        useAnimation: true

        Row {
          id: horiClientRow

          anchors.centerIn: parent
          spacing: Config.styles.margins.extraSmall

          // clients
          Repeater {
            model: IpcCompositor.compositor.focusedWsClientList
            delegate: clientItemComp
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
    }
  }

  // vertical layout of the workspace-bar
  Component {
    id: vertClientLayout

    Column {
      anchors.centerIn: parent
      spacing: 0

      Loader {
        active: root.showClientLabel
        visible: active

        sourceComponent: Component {
          MContainer {
            anchors.centerIn: parent

            implicitHeight: clientName.implicitHeight + Config.styles.margins.large
            implicitWidth: clientName.implicitWidth

            MTextBox {
              id: clientName

              anchors.centerIn: parent

              boxHeight: Math.round(root.clientItemHeight * 20)
              boxWidth: vertClientInnerCon.implicitWidth

              fgColor: root.clientLabelColor

              fontSize: root.labelFontSize
              fontFamily: root.labelFontFamily
              fitMode: "vertical"
              orientation: "vertical"

              text: IpcCompositor.compositor.focusedClient?.title ?? ""
            }
          }
        }
      }

      MContainer {
        id: vertClientInnerCon

        implicitHeight: vertClientColumn.implicitHeight ? vertClientColumn.implicitHeight + Config.styles.margins.large : 0
        implicitWidth: vertClientColumn.implicitWidth ? vertClientColumn.implicitWidth + Config.styles.margins.extraSmall : 0

        // inner-container corner radius
        bottomLeftRadius: Config.options.useRounding ? (root.contCornersToRound[0] ? root.outContRounding : 0) : 0
        bottomRightRadius: Config.options.useRounding ? (root.contCornersToRound[1] ? root.outContRounding : 0) : 0
        topRightRadius: Config.options.useRounding ? (root.contCornersToRound[2] ? root.outContRounding : 0) : 0
        topLeftRadius: Config.options.useRounding ? (root.contCornersToRound[3] ? root.outContRounding : 0) : 0

        color: root.inContColor

        useAnimation: true

        Column {
          id: vertClientColumn

          anchors.centerIn: parent
          spacing: Config.styles.margins.extraSmall

          // clients
          Repeater {
            model: IpcCompositor.compositor.focusedWsClientList
            delegate: clientItemComp
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
    }
  }

  // load horizontal or vertical layout depending on preference
  Loader {
    id: clientLayoutLoader

    // align the inner-container to the left side of the outer-container;
    // need this for label animation
    anchors.right: parent.right

    sourceComponent: root.isVertical ? vertClientLayout : horiClientLayout
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
