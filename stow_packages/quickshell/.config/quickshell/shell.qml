import Quickshell
import QtQuick

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 30

  Text {
    anchors.centerIn: parent

    text: "hello world"
  }
}
