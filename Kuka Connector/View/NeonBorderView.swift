//
//  NeonBorderView.swift
//  Kuka Connector
//
//  Created by iosdeveloper on 02.03.2023.
//

import UIKit

class NeonBorderView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 1
        self.layer.borderColor = ColorNamesEnum.BacklightGreenButton.cgColor.copy(alpha: 0.5)
        self.backgroundColor = ColorNamesEnum.BackgroundView.uiColor
        
        self.layer.shadowColor = ColorNamesEnum.BacklightGreenButton.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.3
        
        let outerRect = CGRect(x: self.bounds.minX - 2, y: self.bounds.minY - 2, width: self.bounds.width + 4, height: self.bounds.height + 4)
        let cgPath = UIBezierPath(rect: outerRect).cgPath
        self.layer.shadowPath = cgPath
    }
}
