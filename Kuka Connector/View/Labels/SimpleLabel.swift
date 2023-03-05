//
//  SimpleLabel.swift
//  Kuka Connector
//
//  Created by Пользователь on 05.03.2023.
//

import UIKit

class SimpleLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.layer.cornerRadius = 5
        self.layer.borderColor = ColorNamesEnum.BacklightGreenButton.cgColor.copy(alpha: 0.1)
        self.layer.borderWidth = 1
        self.font = Customization.getCustomFont(font: .Menlo, size: 17, width: .bold)
        self.tintColor = ColorNamesEnum.LabelTint.uiColor.withAlphaComponent(0.7)
        self.textColor = ColorNamesEnum.LabelTint.uiColor.withAlphaComponent(0.5)
    }
}
