//
//  Enums.swift
//  Kuka Connector
//
//  Created by iosdeveloper on 27.02.2023.
//

import UIKit

enum ColorNamesEnum: String {
    case MainGreenButton = "MainGreenButton"
    case MainPurpleButton = "MainPurpleButton"
    case BacklightGreenButton = "BacklightGreenButton"
    case BacklightPurpleButton = "BacklightPurpleButton"
    case TextGreenButton = "TextGreenButton"
    case TextPurpleButton = "TextPurpleButton"
    
    var uiColor: UIColor {
        return UIColor(named: self.rawValue)!
    }
    
    var cgColor: CGColor {
        return UIColor(named: self.rawValue)!.cgColor
    }
}
