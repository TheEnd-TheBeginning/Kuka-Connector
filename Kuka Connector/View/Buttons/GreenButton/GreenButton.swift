//
//  GreenButton.swift
//  Kuka Connector
//
//  Created by iosdeveloper on 27.02.2023.
//

import UIKit

class GreenButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = ColorNamesEnum.MainGreenButton.uiColor.withAlphaComponent(0.3)
        self.clipsToBounds = true
        if isEnabled {
            self.touchUp()
        } else {
            self.touchDown()
        }
        let attributedLabel = Customization.getCustomLabel(labelString: "ПОДКЛЮЧИТЬСЯ", labelColor: ColorNamesEnum.TextGreenButton.uiColor, shadowColor: ColorNamesEnum.BacklightGreenButton.uiColor)
        self.setAttributedTitle(attributedLabel, for: .disabled)
        self.setAttributedTitle(attributedLabel, for: .normal)
    }
    
    func touchDown() {
        self.layer.backgroundColor = ColorNamesEnum.MainGreenButton.cgColor.copy(alpha: 0.5)
        self.layer.cornerRadius = 10
        self.layer.borderColor = ColorNamesEnum.BacklightGreenButton.cgColor.copy(alpha: 0.3)
        self.layer.borderWidth = 0.1

        self.layer.shadowColor = UIColor.clear.cgColor//ColorNamesEnum.BacklightGreenButton.cgColor.copy(alpha: 0.5)
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 0
        let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 0.0, height: 0.0)).cgPath
        self.layer.shadowPath = cgPath
    }

    func touchUp() {
        self.layer.backgroundColor = ColorNamesEnum.MainGreenButton.cgColor
        self.layer.cornerRadius = 10
        self.layer.borderColor = ColorNamesEnum.BacklightGreenButton.cgColor
        self.layer.borderWidth = 3.0
        
        self.layer.shadowColor = ColorNamesEnum.BacklightGreenButton.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.9
        let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 10.0, height: 10.0)).cgPath
        self.layer.shadowPath = cgPath
    }
    
}
