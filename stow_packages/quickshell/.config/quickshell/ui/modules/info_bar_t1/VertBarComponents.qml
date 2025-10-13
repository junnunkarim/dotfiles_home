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

  Column {
    id: components

    spacing: Config.styles.margins.small

    // start section
    Column {
      spacing: Config.styles.margins.small

      Clock {
        anchors.horizontalCenter: parent.horizontalCenter

        fgColor: root.config.clockFgColor
        bgColor: root.config.clockBgColor
        textBoxSize: root.config.textBoxSize
        scale: root.config.scale
        includeSeparator: root.config.includeSeparator
        separatorThickness: root.config.componentSepThickness
      }
      Date {
        anchors.horizontalCenter: parent.horizontalCenter

        fgColor: root.config.dateFgColor
        bgColor: root.config.dateBgColor
        textBoxSize: root.config.textBoxSize
        scale: root.config.scale
        includeSeparator: root.config.includeSeparator
        separatorThickness: root.config.componentSepThickness
      }
    }

    // separator
    BarSeparator {
      anchors.horizontalCenter: parent.horizontalCenter
      length: parent.width
    }

    // end section
    Column {
      id: end

      spacing: Config.styles.margins.small

      BatteryT1 {
        anchors.horizontalCenter: parent.horizontalCenter
      }

      // Clock {
      //   anchors.horizontalCenter: parent.horizontalCenter
      //
      //   fgColor: config.clockFgColor
      //   bgColor: config.clockBgColor
      //   textBoxSize: config.textBoxSize
      //   scale: config.scale
      //   includeSeparator: config.includeSeparator
      //   separatorThickness: config.componentSepThickness
      // }
      // Date {
      //   anchors.horizontalCenter: parent.horizontalCenter
      //
      //   fgColor: config.dateFgColor
      //   bgColor: config.dateBgColor
      //   textBoxSize: config.textBoxSize
      //   scale: config.scale
      //   includeSeparator: config.componentSepThickness
      //   separatorThickness: config.componentSepThickness
      // }
    }
  }
}
