pragma ComponentBehavior: Bound

import QtQuick

QtObject {
  id: typographyTokens

  property string sans: "Iosevka"
  property string serif: "Iosevka Slab"
  property string mono: "Iosevka Slab"
  property string icon: "Symbols Nerd Font"

  property real baseSize: 14
  readonly property real scaleRatio: 1.125

  component FontSpecs: QtObject {
    required property string family
    required property int weight
    required property real letterSpacing

    required property int step

    property int pixelSize: Math.round(typographyTokens.baseSize * Math.pow(typographyTokens.scaleRatio, step))
    property int lineHeight: Math.round(pixelSize * 1.4)
  }

  component FontStyles: QtObject {
    required property FontSpecs large
    required property FontSpecs medium
    required property FontSpecs small
  }

  readonly property FontStyles display: FontStyles {
    small: FontSpecs {
      family: typographyTokens.sans
      step: 8
      weight: Font.Normal
      letterSpacing: 0.0
    }
    medium: FontSpecs {
      family: typographyTokens.sans
      step: 10
      weight: Font.Normal
      letterSpacing: 0.0
    }
    large: FontSpecs {
      family: typographyTokens.sans
      step: 12
      weight: Font.Normal
      letterSpacing: -0.25
    }
  }

  readonly property FontStyles headline: FontStyles {
    small: FontSpecs {
      family: typographyTokens.sans
      step: 5
      weight: Font.Normal
      letterSpacing: 0.0
    }
    medium: FontSpecs {
      family: typographyTokens.sans
      step: 6
      weight: Font.Normal
      letterSpacing: 0.0
    }
    large: FontSpecs {
      family: typographyTokens.sans
      step: 7
      weight: Font.Normal
      letterSpacing: 0.0
    }
  }

  readonly property FontStyles title: FontStyles {
    small: FontSpecs {
      family: typographyTokens.sans
      step: 0
      weight: Font.Medium
      letterSpacing: 0.1
    }
    medium: FontSpecs {
      family: typographyTokens.sans
      step: 1
      weight: Font.Medium
      letterSpacing: 0.15
    }
    large: FontSpecs {
      family: typographyTokens.sans
      step: 4
      weight: Font.Normal
      letterSpacing: 0.0
    }
  }

  readonly property FontStyles body: FontStyles {
    small: FontSpecs {
      family: typographyTokens.sans
      step: -1
      weight: Font.Normal
      letterSpacing: 0.4
    }
    medium: FontSpecs {
      family: typographyTokens.sans
      step: 0
      weight: Font.Normal
      letterSpacing: 0.25
    }
    large: FontSpecs {
      family: typographyTokens.sans
      step: 1
      weight: Font.Normal
      letterSpacing: 0.5
    }
  }

  readonly property FontStyles label: FontStyles {
    small: FontSpecs {
      family: typographyTokens.sans
      step: -2
      weight: Font.Medium
      letterSpacing: 0.5
    }
    medium: FontSpecs {
      family: typographyTokens.sans
      step: -1
      weight: Font.Medium
      letterSpacing: 0.5
    }
    large: FontSpecs {
      family: typographyTokens.sans
      step: 0
      weight: Font.Medium
      letterSpacing: 0.1
    }
  }
}
