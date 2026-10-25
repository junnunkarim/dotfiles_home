import QtQuick
import QtQuick.Layouts

import qs.ui.components.containers
import qs.ui.modules.ws_bar

Item {
  id: barLayout

  // component WsBar: WsBarLean {
  //   id: wsBar
  //
  //   length: root.barLength
  //   position: root.barPosition
  //   isVertical: root.isBarVertical
  //
  //   Layout.fillWidth: true
  //   Layout.fillHeight: false
  // }

  Component {
    id: horiLayout

    RowLayout {
      spacing: 32

      // components
      // WsBar {}

      AContainer {
        Layout.fillWidth: true
        implicitHeight: 18
        color: "#404040"
        radius: 12
        useAnimation: true
      }

      AContainer {
        Layout.fillWidth: true
        implicitHeight: 18
        color: "#404040"
        radius: 12
        useAnimation: true
      }
    }
  }

  Loader {
    id: barLayoutLoader

    sourceComponent: horiLayout
  }
}
