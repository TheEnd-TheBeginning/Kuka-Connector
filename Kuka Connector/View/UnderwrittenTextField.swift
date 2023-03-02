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
        self.font = UIFont(name: "Monle", size: 17)
        self.layer.cornerRadius = 5
//        self.clipsToBounds = false
        self.borderStyle = .roundedRect
    }
}