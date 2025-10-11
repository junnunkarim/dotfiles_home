pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland 

import qs.configs
import qs.ui.components.containers
// import qs.services.window_managers

Item {
  id: tagClients

  property real clientHeight: 12
  property real clientWidth: 12

  property color focusedColor: "#e69875"
  property color unfocusedColor: "#859289"
  property color urgentColor: "#e67e80"
  property string orientation: "horizontal"
  property real focusedRounding: Config.styles.roundings.small
  property real unfocusedRounding: Config.styles.roundings.extraSmall

  readonly property bool isVertical: orientation == "vertical"

  implicitHeight: loader.item.implicitHeight
  implicitWidth: loader.item.implicitWidth

  Component {
    id: horiTagClientsLayout

    RowLayout {
      spacing: Config.styles.margins.extraSmall

      Repeater {
        // model: Hyprland.workspaces
        model: WmIpc.wm.focusedTagToplevels

        TagClient {
          id: tagItem

          required property var modelData

          boxHeight: tagClients.clientHeight
          boxWidth: tagClients.clientWidth

          isFocused: modelData.isFocused
          isUrgent: modelData.isUrgent

          focusedColor: tagClients.focusedColor
          unfocusedColor: tagClients.unfocusedColor
          urgentColor: tagClients.urgentColor

          orientation: tagClients.orientation
          focusedRounding: tagClients.focusedRounding
          unfocusedRounding: tagClients.unfocusedRounding

          // Component.onCompleted: {
          //   console.log("Value of title:", modelData.title)
          //   console.log("Value of focused:", modelData.focused)
          //   console.log("Value of urgent:", modelData.urgent)
          // }
        }
      }
    }
  }

  Component {
    id: vertTagClientsLayout

    ColumnLayout {
      Repeater {
        model: WmIpc.wm.focusedTagToplevels

        TagClient {
          id: tagItem

          required property var modelData

          boxHeight: tagClients.clientHeight
          boxWidth: tagClients.clientWidth

          isFocused: modelData.focused
          isUrgent: modelData.urgent

          focusedColor: tagClients.focusedColor
          unfocusedColor: tagClients.unfocusedColor
          urgentColor: tagClients.urgentColor

          orientation: tagClients.orientation
          focusedRounding: tagClients.focusedRounding
          unfocusedRounding: tagClients.unfocusedRounding
        }
      }
    }
  }

  Loader {
    id: loader

    anchors.centerIn: parent

    sourceComponent: isVertical ? vertTagClientsLayout : horiTagClientsLayout

    Component.onCompleted: {
      console.log("focusedTagToplevels: ", WmIpc.wm.focusedTagToplevels)
    }
  }
}
