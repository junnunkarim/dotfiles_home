pragma ComponentBehavior: Bound

import QtQuick

import qs.configs
import qs.ui.components
import qs.ui.modules.battery_t1

Item {
  id: root

  required property QtObject config

  anchors.centerIn: parent

  implicitHeight: components.implicitHeight
  implicitWidth: components.implicitWidth
  
  component BarSeparator: Loader {
    id: sepLoader

    required property real length

    active: true
    visible: active

    sourceComponent: MSeparator {
      length: sepLoader.length
      thickness: Math.round(root.config.barSepThickness * root.config.scale)
      margins: Math.round(sepLoader.length * 0.05)
      separatorColor: root.config.barSeparatorColor
      orientation: root.config.orientation
      opacity: 0.5
    }
  }

  Row {
    id: components

    spacing: Config.styles.margins.small

    // start section
    Row {
      spacing: Config.styles.margins.small

      Clock {
        anchors.verticalCenter: parent.verticalCenter

        fgColor: root.config.clockFgColor
        bgColor: root.config.clockBgColor
        textBoxSize: root.config.textBoxSize
        scale: root.config.scale
        includeSeparator: root.config.includeSeparator
        separatorThickness: root.config.componentSepThickness
        orientation: root.config.orientation
      }
      Date {
        anchors.verticalCenter: parent.verticalCenter

        fgColor: root.config.dateFgColor
        bgColor: root.config.dateBgColor
        textBoxSize: root.config.textBoxSize
        scale: root.config.scale
        includeSeparator: root.config.includeSeparator
        separatorThickness: root.config.componentSepThickness
        orientation: root.config.orientation
      }
    }

    // separator
    BarSeparator {
      anchors.verticalCenter: parent.verticalCenter
      length: root.implicitHeight
    }

    // end section
    Row {
      spacing: Config.styles.margins.small

      BatteryT1 {
        anchors.verticalCenter: parent.verticalCenter
      }

      // Clock {
      //   anchors.verticalCenter: parent.verticalCenter
      //
      //   fgColor: root.config.clockFgColor
      //   bgColor: root.config.clockBgColor
      //   textBoxSize: root.config.textBoxSize
      //   scale: root.config.scale
      //   includeSeparator: root.config.includeSeparator
      //   separatorThickness: root.config.componentSepThickness
      //   orientation: root.config.orientation
      // }
      // Date {
      //   anchors.verticalCenter: parent.verticalCenter
      //
      //   fgColor: root.config.dateFgColor
      //   bgColor: root.config.dateBgColor
      //   textBoxSize: root.config.textBoxSize
      //   scale: root.config.scale
      //   includeSeparator: root.config.includeSeparator
      //   separatorThickness: root.config.componentSepThickness
      //   orientation: root.config.orientation
      // }
    }
  }
}
