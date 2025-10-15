pragma ComponentBehavior: Bound

import QtQuick

import qs.configs
import qs.ui.components
import qs.ui.modules.clock_t1
import qs.ui.modules.date_t1
import qs.ui.modules.battery_t1

Column {
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
  Column {
    anchors.horizontalCenter: parent.horizontalCenter
    spacing: Math.round(Config.styles.margins.sM * root.config.scale)

    ClockT1 {
      anchors.horizontalCenter: parent.horizontalCenter

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
      anchors.horizontalCenter: parent.horizontalCenter

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
    anchors.horizontalCenter: parent.horizontalCenter
    length: parent.width
  }

  // end section
  Column {
    anchors.horizontalCenter: parent.horizontalCenter
    spacing: Math.round(Config.styles.margins.sM * root.config.scale)

    BatteryT1 {
      anchors.horizontalCenter: parent.horizontalCenter
      scale: root.config.scale
    }
  }
}
