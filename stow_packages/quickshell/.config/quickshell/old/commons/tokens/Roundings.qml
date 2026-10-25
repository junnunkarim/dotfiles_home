import QtQuick

QtObject {
  id: roundingTokens

  property int enable: 1
  property int gridBase: 4 * enable
  onGridBaseChanged: {
    if (gridBase <= 0)
      gridBase = 1 * enable;
  }

  readonly property int verySmall: 1 * gridBase
  readonly property int extraSmall: 2 * gridBase
  readonly property int small: 3 * gridBase
  readonly property int normal: 4 * gridBase
  readonly property int large: 5 * gridBase
  readonly property int extraLarge: 6 * gridBase
  readonly property int veryLarge: 7 * gridBase
  readonly property int almostFull: 36 * enable
  readonly property int full: 1000 * enable
}
