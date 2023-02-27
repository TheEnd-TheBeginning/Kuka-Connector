//
//  PurpleButton.swift
//  Kuka Connector
//
//  Created by iosdeveloper on 27.02.2023.
//

import UIKit

class PurpleButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func draw(_ rect: CGRect) {
        self.backgroundColor = UIColor(named: ColorNamesEnum.MainPurpleButton.rawValue)
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor(named: ColorNamesEnum.BacklightPurpleButton.rawValue)?.cgColor
        self.layer.borderWidth = 3.0
        self.layer.shadowColor = UIColor(named: ColorNamesEnum.BacklightPurpleButton.rawValue)?.cgColor
        self.layer.shadowRadius = 3.0
        self.tintColor = UIColor(named: ColorNamesEnum.TextPurpleButton.rawValue)
        self.setTitle("ОТКЛЮЧИТЬСЯ", for: .normal)
    }

}
