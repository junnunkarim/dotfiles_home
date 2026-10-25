pragma Singleton

import Quickshell

Singleton {
  id: styleTokens

  readonly property Spacings spacings: Spacings {}
  readonly property Roundings roundings: Roundings {}
  readonly property Typography typography: Typography {}
  readonly property Animations animations: Animations {}
}
