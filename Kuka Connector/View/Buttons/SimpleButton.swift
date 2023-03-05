//
//  SimpleButton.swift
//  Kuka Connector
//
//  Created by Пользователь on 05.03.2023.
//

import UIKit

class SimpleButton: UIButton {
    var buttonTextLabel: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = ColorNamesEnum.MainGreenButton.cgColor.copy(alpha: 0.5)
        self.backgroundColor = ColorNamesEnum.BacklightGreenButton.uiColor.withAlphaComponent(0.5)
        self.buttonTextLabel = self.currentTitle ?? ""
        var attributedLabel = Customization.getCustomLabel(labelString: self.buttonTextLabel, labelColor: ColorNamesEnum.MainGreenButton.uiColor, shadowColor: .clear)
        self.setAttributedTitle(attributedLabel, for: .normal)
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
