//
//  Customization.swift
//  Kuka Connector
//
//  Created by iosdeveloper on 27.02.2023.
//

import UIKit

class Customization {
    enum TextWidth: String {
        case regular = ""
        case bold = "-Bold"
    }
    
    static func getCustomLabel(labelString: String, labelColor: UIColor, shadowColor: UIColor) -> NSMutableAttributedString {
        let labelShadow = NSShadow()
        labelShadow.shadowOffset = CGSize(width: 0, height: 0)
        labelShadow.shadowColor = shadowColor
        labelShadow.shadowBlurRadius = 3.0
        let normalAttrs: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: Customization.getCustomFont(font: .Menlo, size: 20.0, width: .bold) as Any, NSAttributedString.Key.foregroundColor: labelColor]
        let normalAttributedString = NSMutableAttributedString(string: labelString, attributes: normalAttrs)
        return normalAttributedString
    }
    
    static func getCustomFont(font: FontNamesEnum, size: CGFloat, width: TextWidth) -> UIFont {
        return UIFont(name: font.rawValue + width.rawValue, size: size)!
    }
}
