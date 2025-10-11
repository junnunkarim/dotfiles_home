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


  ColumnLayout {
    id: components

    Layout.alignment: Qt.AlignHCenter
    spacing: Config.styles.margins.small

    // start section
    ColumnLayout {
      Layout.alignment: Qt.AlignHCenter
      spacing: Config.styles.margins.small

      Clock {
        Layout.alignment: Qt.AlignHCenter

        fgColor: config.clockFgColor
        bgColor: config.clockBgColor
        textBoxSize: config.textBoxSize
        scale: config.scale
        includeSeparator: config.includeSeparator
        separatorThickness: config.componentSepThickness
      }
      Date {
        Layout.alignment: Qt.AlignHCenter

        fgColor: config.dateFgColor
        bgColor: config.dateBgColor
        textBoxSize: config.textBoxSize
        scale: config.scale
        includeSeparator: config.includeSeparator
        separatorThickness: config.componentSepThickness
      }
    }

    // separator
    // BarSeparator {
    //   Layout.alignment: Qt.AlignHCenter
    // }
    //
    // // end section
    // ColumnLayout {
    //   id: end
    //
    //   Layout.alignment: Qt.AlignHCenter
    //   spacing: Config.styles.margins.small
    //
    //   Clock {
    //     Layout.alignment: Qt.AlignHCenter
    //
    //     fgColor: config.clockFgColor
    //     bgColor: config.clockBgColor
    //     textBoxSize: config.textBoxSize
    //     scale: config.scale
    //     includeSeparator: config.includeSeparator
    //     separatorThickness: config.componentSepThickness
    //   }
    //   Date {
    //     Layout.alignment: Qt.AlignHCenter
    //
    //     fgColor: config.dateFgColor
    //     bgColor: config.dateBgColor
    //     textBoxSize: config.textBoxSize
    //     scale: config.scale
    //     includeSeparator: config.componentSepThickness
    //     separatorThickness: config.componentSepThickness
    //   }
    // }
  }
}
