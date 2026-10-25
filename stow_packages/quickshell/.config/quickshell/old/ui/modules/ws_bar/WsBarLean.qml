pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Window

import qs.commons.tokens
import qs.configs
import qs.services
import qs.ui.components
import qs.ui.components.animations
import qs.ui.components.containers
import qs.ui.modules.ws_bar

Item {
  id: wsBarLean

  required property string position
  required property bool isVertical

  property color contColor: "#282828" // main container color
  property color baseColor: "#504945" // workspace base color
  property color specialWsColor: "#c4a7e7" // special workspace color
  property color occupiedColor: "#7c6f64" // occupied workspace color
  property color focusColor: "#b8bb26" // focused workspace color
  property color urgentColor: "#fb4934" // urgent workspace color
  property color hoverColor: "#83a598" // workspace hover color
  property color labelColor: "#1f1d2e" // workspace label color

  property bool useRounding: Config.options.useRounding
  property real containerRounding: StyleTokens.roundings.normal
  property real baseRounding: StyleTokens.roundings.extraSmall
  property real occupiedRounding: StyleTokens.roundings.normal
  property real focusedRounding: StyleTokens.roundings.full

  // workspace-item height and width multiplier
  property real baseItemRatio: 1
  property real occupiedItemRatio: 2
  property real focusedItemRatio: 3

  property int horiMargin: wsBarLean.isVertical ? 16 : 6
  property int vertMargin: wsBarLean.isVertical ? 6 : 16

  function getContainerRadius(
    radiusPosition: string,
    position: string,
    radius: double,
  ): double {
    switch (radiusPosition) {
    case "topRight":
      switch (position) {
      case "bottom":
        return radius;
      default:
        return 0;
      }
    case "bottomLeft":
      switch (position) {
      case "right":
        return radius;
      default:
        return 0;
      }
    case "bottomRight":
      switch (true) {
      case position === "top":
      case position === "left":
        return radius;
      default:
        return 0;
      }
    default:
      return 0;
    }
  }

  height: wsBarLean.isVertical ? 1 : wsContainer.implicitHeight
  width: wsBarLean.isVertical ? wsContainer.implicitWidth : 1

  // workspace-item component
  component WsItem: Workspace {
    id: workspace

    required property var modelData // get data from Repeater

    baseColor: wsBarLean.baseColor
    hoverColor: wsBarLean.hoverColor
    focusColor: wsBarLean.focusColor
    occupiedColor: wsBarLean.occupiedColor
    urgentColor: wsBarLean.urgentColor
    specialWsColor: wsBarLean.specialWsColor

    isFocused: workspace.modelData?.isFocused || false
    isOccupied: workspace.modelData?.isOccupied || false
    isUrgent: workspace.modelData?.isUrgent || false
    isSpecialWs: workspace.modelData?.isSpecialWs || false

    baseRounding: wsBarLean.baseRounding
    focusedRounding: wsBarLean.focusedRounding
    occupiedRounding: wsBarLean.occupiedRounding

    useRounding: wsBarLean.useRounding

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.preferredHeight: {
      switch (true) {
        case wsBarLean.isVertical:
        switch (true) {
          case workspace.isFocused:
          return wsBarLean.focusedItemRatio;
          case workspace.isOccupied:
          return wsBarLean.occupiedItemRatio;
        }
        default:
        return wsBarLean.baseItemRatio;
      }
    }
    Layout.preferredWidth: {
      switch (true) {
        case !wsBarLean.isVertical:
        switch (true) {
          case workspace.isFocused:
          return wsBarLean.focusedItemRatio;
          case workspace.isOccupied:
          return wsBarLean.occupiedItemRatio;
        }
        default:
        return wsBarLean.baseItemRatio;
      }
    }

    Behavior on Layout.preferredHeight { MSpringAnim {} }
    Behavior on Layout.preferredWidth { MSpringAnim {} }
  } // Workspace

  // horizontal layout of the workspace-bar
  Component {
    id: horiLayout

    RowLayout {
      id: horiRow

      spacing: 6

      Repeater {
        model: IpcCompositor.compositor.wsList
        WsItem {}
      }
      Repeater {
        model: IpcCompositor.compositor.specialWsList
        WsItem {}
      }
    } // RowLayout
  }

  // vertical layout of the workspace-bar
  Component {
    id: vertLayout

    ColumnLayout {
      id: vertColumn

      spacing: 6

      Repeater {
        model: IpcCompositor.compositor.wsList
        WsItem {}
      }
      Repeater {
        model: IpcCompositor.compositor.specialWsList
        WsItem {}
      }
    } // ColumnLayout
  }

  MContainer {
    id: wsContainer

    implicitHeight: wsBarLean.isVertical ? wsBarLean.height : wsBarLean.length
    implicitWidth: wsBarLean.isVertical ? wsBarLean.length: wsBarLean.width

    color: wsBarLean.contColor

    topLeftRadius: 0
    topRightRadius: wsBarLean.getContainerRadius(
      "topRight",
      wsBarLean.position,
      wsBarLean.contRounding,
    )
    bottomLeftRadius: wsBarLean.getContainerRadius(
      "bottomLeft",
      wsBarLean.position,
      wsBarLean.contRounding,
    )
    bottomRightRadius: wsBarLean.getContainerRadius(
      "bottomRight",
      wsBarLean.position,
      wsBarLean.contRounding,
    )

    useAnimation: Config.options.useAnimation

    Loader {
      id: layoutLoader

      anchors.fill: wsContainer
      // margins
      anchors {
        topMargin: wsBarLean.horiMargin
        bottomMargin: wsBarLean.horiMargin
        leftMargin: wsBarLean.vertMargin
        rightMargin: wsBarLean.vertMargin
      }

      sourceComponent: wsBarLean.isVertical ? vertLayout : horiLayout
    }
  } // MContainer

  // shadow
  MElevation {
    level: 3
    anchors.fill: wsBarLean
    radius: wsBarLean.contRounding
  } // MElevation

  MouseArea {
    // signal handlers
    onEntered: {
      switch (true) {
        case wsBarLean.isVertical:
        wsContainer.implicitWidth = wsBarLean.length * 4
        break;
        default:
        wsContainer.implicitHeight = wsBarLean.length * 4
        break;
      }
    }
    onExited: {
      switch (true) {
        case wsBarLean.isVertical:
        wsContainer.implicitWidth = wsBarLean.length
        break;
        default:
        wsContainer.implicitHeight = wsBarLean.length
        break;
      }
    }

    // object properties
    anchors.fill: wsBarLean
    hoverEnabled: true
    propagateComposedEvents: true
    // z: -1
  } // MouseArea
}
