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
        
        self.layer.borderWidth = 2
        self.layer.borderColor = ColorNamesEnum.BacklightTextGreenButton.cgColor
        self.layer.cornerRadius = 10
        
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowColor = ColorNamesEnum.BacklightTextGreenButton.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 10
        

        
        self.backgroundColor = .clear
        self.buttonTextLabel = self.currentTitle ?? ""
        let attributedLabel = Customization.getCustomLabel(labelString: self.buttonTextLabel, labelColor: ColorNamesEnum.BacklightGreenButton.uiColor.withAlphaComponent(0.5), shadowColor: .clear)
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
