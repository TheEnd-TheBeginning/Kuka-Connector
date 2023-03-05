//
//  UnderwrittenTextField.swift
//  Kuka Connector
//
//  Created by iosdeveloper on 02.03.2023.
//

import UIKit

class UnderwrittenTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.backgroundColor = ColorNamesEnum.BackgroundTextField.cgColor
        self.textColor = UIColor.black.withAlphaComponent(0.5)
        self.layer.borderColor = UIColor.black.cgColor.copy(alpha: 0.2)
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 5
        self.borderStyle = .roundedRect
        self.font = Customization.getCustomFont(font: .Menlo, size: 17, width: .regular)
    }
}
//
////если поле под айпишник
//extension UnderwrittenTextField {
//    func isCorrect() {
////        var separatedArray = self.text.components(separatedBy: ".")
////        if
////        if ()
//    }
//}
//
////если поле под порт
//extension UnderwrittenTextField {
//    
//}
