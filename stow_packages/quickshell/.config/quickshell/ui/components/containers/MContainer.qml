import QtQuick

import qs.configs
import qs.ui.components.animations

Rectangle {
  id: root

  color: "transparent"

  // [DEBUG]: this makes it easy to debug layout issues
  // border {
  //   color: "#dc143c"
  // }

  Behavior on implicitHeight {
    MSpringAnimation {}
  }
  Behavior on implicitWidth {
    MSpringAnimation {}
  }
}
