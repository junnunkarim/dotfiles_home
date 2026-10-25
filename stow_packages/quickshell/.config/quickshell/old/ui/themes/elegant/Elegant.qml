pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

import Quickshell
import Quickshell.Io

import qs.configs
import qs.ui.components.containers
import qs.ui.components.animations
// import qs.ui.modules.info_bar
import qs.ui.themes.elegant

Variants {
  // contains list of all available screens
  model: Quickshell.screens

  PanelWindow {
    id: mainWindow

    // - data about outputs/screens
    // - get data from Variants
    required property var modelData

    color: "transparent"

    screen: modelData
    // span across whole screen
    anchors {
      top: true
      bottom: true
      left: true
      right: true
    }
    // don't reserve space because individual components reserve their own space
    exclusionMode: ExclusionMode.Ignore

    // make everything click-through except specified regions
    mask: Region {
      id: clickableMaskRegion

      // everything is masked/click-through
      x: 0
      y: 0
      height: mainWindow.height
      width: mainWindow.width

      intersection: Intersection.Xor

      // only include regions that are actually needed
      // regions: [barMaskRegion]

      // substract bar area from mask
      // Region {
      //   id: barMaskRegion
      //
      //   x: layoutLoader.x
      //   y: layoutLoader.y
      //
      //   height: root.isBarVertical ? layoutLoader.height : root.barLength
      //   width: root.isBarVertical ? root.barLength : layoutLoader.width
      //
      //   intersection: Intersection.Subtract
      // }
    }

    Item {
      id: root

      anchors.fill: parent

      BarLayout {
        id: barLayout

        anchors.bottom: parent.bottom
      }
    } // Item
  } // PanelWindow
} // Variants
