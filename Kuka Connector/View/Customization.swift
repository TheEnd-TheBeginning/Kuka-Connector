//
//  Customization.swift
//  Kuka Connector
//
//  Created by iosdeveloper on 27.02.2023.
//

import UIKit

class Customization {
    static func getCustomLabel(labelString: String, labelColor: UIColor, shadowColor: UIColor) -> NSMutableAttributedString {
        let labelShadow = NSShadow()
        labelShadow.shadowColor = shadowColor
        labelShadow.shadowBlurRadius = 5.0
        let normalAttrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: labelColor, NSAttributedString.Key.shadow: labelShadow]
        let normalAttributedString = NSMutableAttributedString(string: labelString, attributes:  normalAttrs)
        return normalAttributedString
    }
}
