pragma ComponentBehavior: Bound

import QtQuick

import qs.logic.configs
import qs.ui.components
import qs.ui.modules.clock
import qs.ui.modules.date
import qs.ui.modules.battery

Row {
  id: root

  required property QtObject config

  spacing: Math.round(Config.styles.margins.sM * root.config.scale)

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

  // start section
  Row {
    anchors.verticalCenter: parent.verticalCenter
    spacing: Math.round(Config.styles.margins.sM * root.config.scale)

    ClockT1 {
      anchors.verticalCenter: parent.verticalCenter

      fgColor: root.config.clockFgColor
      bgColor: root.config.clockBgColor
      borderColor: root.config.clockBorderColor

      useBorder: root.config.useClockBorder

      includeSeparator: root.config.includeSeparator
      separatorThickness: root.config.componentSepThickness
      scale: root.config.scale
      orientation: root.config.orientation
    }

    DateT1 {
      anchors.verticalCenter: parent.verticalCenter

      fgColor: root.config.dateFgColor
      bgColor: root.config.dateBgColor
      borderColor: root.config.dateBorderColor

      useBorder: root.config.useDateBorder

      includeSeparator: root.config.includeSeparator
      separatorThickness: root.config.componentSepThickness
      scale: root.config.scale
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
    anchors.verticalCenter: parent.verticalCenter
    spacing: Math.round(Config.styles.margins.sM * root.config.scale)

    BatteryT1 {
      anchors.verticalCenter: parent.verticalCenter
      scale: root.config.scale
    }

    MSysTray {
      anchors.verticalCenter: parent.verticalCenter
    }
  }
}
