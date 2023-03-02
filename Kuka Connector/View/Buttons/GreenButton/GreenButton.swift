////
////  GreenButton.swift
////  Kuka Connector
////
////  Created by iosdeveloper on 27.02.2023.
////
//
//import UIKit
//
//
//
//class GreenButton: UIButton {
//
//    /*
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
//    */
//    
//    override func draw(_ rect: CGRect) {
////        self.backgroundColor = ColorNamesEnum.MainGreenButton.uiColor.withAlphaComponent(0.3)
////        self.clipsToBounds = true
//        self.backgroundColor = .clear
//        if isEnabled {
//            self.touchUp()
//        } else {
//            self.touchDown()
//        }
//        let attributedLabel = Customization.getCustomLabel(labelString: "ПОДКЛЮЧИТЬСЯ", labelColor: ColorNamesEnum.TextGreenButton.uiColor, shadowColor: ColorNamesEnum.BacklightGreenButton.uiColor)
//        self.setAttributedTitle(attributedLabel, for: .disabled)
//        self.setAttributedTitle(attributedLabel, for: .normal)
//        
//        labelShadow.shadowColor = ColorNamesEnum.TextGreenButton.uiColor
//        ColorNamesEnum.BacklightGreenButton.uiColor.withAlphaComponent(0.5)
////        let innerRect = CGRect(x: self.bounds.minX + 10, y: self.bounds.maxY + 10, width: self.bounds.width - 10, height: self.bounds.height - 10)
//        let outerRect = CGRect(x: self.bounds.minX - 5, y: self.bounds.minY - 5, width: self.bounds.width + 10, height: self.bounds.height + 15)
//        let cgPath = UIBezierPath(roundedRect: outerRect, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 10.0, height: 10.0)).cgPath
//        self.layer.shadowPath = cgPath
//    }
//    
//    func touchDown() {
//        self.layer.backgroundColor = ColorNamesEnum.MainGreenButton.cgColor.copy(alpha: 0.5)
//        self.layer.cornerRadius = 10
//        self.layer.borderColor = ColorNamesEnum.BacklightGreenButton.cgColor.copy(alpha: 0.3)
//        self.layer.borderWidth = 3.0
//
//        self.layer.shadowColor = UIColor.black.cgColor//ColorNamesEnum.BacklightGreenButton.cgColor.copy(alpha: 0.5)
////        self.layer.shadowRadius = 5
//        self.layer.shadowOpacity = 0.3
////        let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 0.0, height: 0.0)).cgPath
////        self.layer.shadowPath = cgPath
//    }
//
//    func touchUp() {
//        self.layer.backgroundColor = ColorNamesEnum.MainGreenButton.cgColor
//        self.layer.cornerRadius = 10
//        self.layer.borderColor = ColorNamesEnum.BacklightGreenButton.cgColor
//        self.layer.borderWidth = 5.0
//        
//        self.layer.shadowColor = ColorNamesEnum.BacklightGreenButton.cgColor
////        self.layer.shadowRadius = 5
//        self.layer.shadowOpacity = 0.7
////        let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 10.0, height: 10.0)).cgPath
////        self.layer.shadowPath = cgPath
//    }
//    
//}
