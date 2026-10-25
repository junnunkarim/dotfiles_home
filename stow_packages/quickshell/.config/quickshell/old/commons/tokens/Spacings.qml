import QtQuick

QtObject {
  id: spacingTokens

  property int gridBase: 4
  onGridBaseChanged: {
    if (gridBase <= 0)
      gridBase = 1;
  }

  readonly property int verySmall: 1 * gridBase
  readonly property int extraSmall: 2 * gridBase
  readonly property int small: 3 * gridBase
  readonly property int normal: 4 * gridBase
  readonly property int large: 5 * gridBase
  readonly property int extraLarge: 6 * gridBase
  readonly property int veryLarge: 7 * gridBase
}
