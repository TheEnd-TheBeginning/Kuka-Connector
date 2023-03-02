//
//  NeonBorderView.swift
//  Kuka Connector
//
//  Created by iosdeveloper on 02.03.2023.
//

import UIKit

class NeonBorderView: UIView {
    override func draw(_ rect: CGRect) {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = ColorNamesEnum.BacklightGreenButton.cgColor.copy(alpha: 0.5)
        self.backgroundColor = .clear
    }

}
