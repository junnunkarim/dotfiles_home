pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.configs
import qs.ui.components

Item {
  id: root

  required property QtObject config

  anchors.centerIn: parent

  implicitHeight: components.implicitHeight
  implicitWidth: components.implicitWidth
  
  component BarSeparator: MSeparator {
    asynchronous: true
    active: true
    visible: active

    separatorColor: config.barSeparatorColor
    thickness: config.barSepThickness
  }

  RowLayout {
    id: components

    Layout.alignment: Qt.AlignVCenter
    spacing: Config.styles.margins.regular

    // start section
    RowLayout {
      Layout.alignment: Qt.AlignVCenter

      spacing: Config.styles.margins.regular

      Clock {
        Layout.alignment: Qt.AlignVCenter

        fgColor: config.clockFgColor
        bgColor: config.clockBgColor
        textBoxSize: config.textBoxSize
        scale: config.scale
        includeSeparator: config.includeSeparator
        separatorThickness: config.componentSepThickness
      }
      Date {
        Layout.alignment: Qt.AlignVCenter

        fgColor: config.dateFgColor
        bgColor: config.dateBgColor
        textBoxSize: config.textBoxSize
        scale: config.scale
        includeSeparator: config.includeSeparator
        separatorThickness: config.componentSepThickness
      }
    }

    // separator
    BarSeparator {
      Layout.alignment: Qt.AlignVCenter
    }

    // end section
    RowLayout {
      id: end

      Layout.alignment: Qt.AlignVCenter
      spacing: Config.styles.margins.regular

      Clock {
        Layout.alignment: Qt.AlignVCenter

        fgColor: config.clockFgColor
        bgColor: config.clockBgColor
        textBoxSize: config.textBoxSize
        scale: config.scale
        includeSeparator: config.includeSeparator
        separatorThickness: config.componentSepThickness
      }
      Date {
        Layout.alignment: Qt.AlignVCenter

        fgColor: config.dateFgColor
        bgColor: config.dateBgColor
        textBoxSize: config.textBoxSize
        scale: config.scale
        includeSeparator: config.includeSeparator
        separatorThickness: config.componentSepThickness
      }
    }
  }
}
