//
//  Enums.swift
//  Kuka Connector
//
//  Created by iosdeveloper on 27.02.2023.
//

import UIKit



enum FontNamesEnum: String {
    case Menlo = "Menlo"
}

enum ColorNamesEnum: String {
    case MainGreenButton = "MainGreenButton"
    case MainPurpleButton = "MainPurpleButton"
    case BacklightGreenButton = "BacklightGreenButton"
    case BacklightPurpleButton = "BacklightPurpleButton"
    case BacklightTextGreenButton = "BacklightTextGreenButton"
    case BacklightTextPurpleButton = "BacklightTextPurpleButton"
    case BackgroundTextField = "BackgroundTextField"
    case BackgroundView = "BackgroundView"
    
    var uiColor: UIColor {
        return UIColor(named: self.rawValue)!
    }
    
    var cgColor: CGColor {
        return UIColor(named: self.rawValue)!.cgColor
    }
}

enum ButtonColorSetEnum: String {
    case greenButton = "GreenButton"
    case purpleButton = "PurpleButton"
    
    var stateColors: ButtonStateColors {
        var enabledStateColors: NeonButtonColorSet
        switch self {
        case .greenButton:
            enabledStateColors = NeonButtonColorSet(
                mainColor: ColorNamesEnum.MainGreenButton.cgColor,
                backlightColor: ColorNamesEnum.BacklightGreenButton.cgColor,
                textColor: ColorNamesEnum.BacklightTextGreenButton.uiColor,
                textShadowColor: ColorNamesEnum.BacklightGreenButton.uiColor
            )
        case .purpleButton:
            enabledStateColors = NeonButtonColorSet(
                mainColor: ColorNamesEnum.MainPurpleButton.cgColor,
                backlightColor: ColorNamesEnum.BacklightPurpleButton.cgColor,
                textColor: ColorNamesEnum.BacklightTextPurpleButton.uiColor,
                textShadowColor: ColorNamesEnum.BacklightPurpleButton.uiColor
            )
        }
        var buttonStateColors = ButtonStateColors(enabledState: enabledStateColors)
        return buttonStateColors
    }
}
