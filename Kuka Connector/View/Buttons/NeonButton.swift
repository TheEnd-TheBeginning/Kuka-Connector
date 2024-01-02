//
//  NeonButton.swift
//  Kuka Connector
//
//  Created by iosdeveloper on 01.03.2023.
//

import UIKit

struct NeonButtonColorSet {
    let mainColor: CGColor
    let backlightColor: CGColor
    let textColor: UIColor
    let textShadowColor: UIColor
    
    func getDisabled() -> NeonButtonColorSet {
        let disabledStateColors = NeonButtonColorSet(
            mainColor: self.mainColor.copy(alpha: 0.5)!,
            backlightColor: self.textColor.cgColor.copy(alpha: 0.5)!,
            textColor: self.textColor,
            textShadowColor: self.textShadowColor
        )
        return disabledStateColors
    }
}

struct ButtonStateColors {
    let enabledState: NeonButtonColorSet
    let disabledState: NeonButtonColorSet
    
    init(enabledState: NeonButtonColorSet) {
        self.enabledState = enabledState
        self.disabledState = enabledState.getDisabled()
    }
}

class NeonButton: UIButton {
    var buttonColorSet: ButtonColorSetEnum = .greenButton
    var buttonTextLabel: String = "Button"
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.5

        if isEnabled {
            self.touchUp()
        } else {
            self.touchDown()
        }
        
        var attributedLabel = Customization.getCustomLabel(labelString: self.buttonTextLabel, labelColor: self.buttonColorSet.stateColors.enabledState.textColor, shadowColor: self.buttonColorSet.stateColors.enabledState.textColor)
        self.setAttributedTitle(attributedLabel, for: .normal)
        attributedLabel = Customization.getCustomLabel(labelString: self.buttonTextLabel, labelColor: self.buttonColorSet.stateColors.disabledState.textColor, shadowColor: self.buttonColorSet.stateColors.disabledState.textColor)
        self.setAttributedTitle(attributedLabel, for: .disabled)
        
        let outerRect = CGRect(x: self.bounds.minX - 3, y: self.bounds.minY - 3, width: self.bounds.width + 6, height: self.bounds.height + 6)
        let cgPath = UIBezierPath(roundedRect: outerRect, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 10.0, height: 10.0)).cgPath
        self.layer.shadowPath = cgPath
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    }
    
    func touchDown() {
        self.layer.backgroundColor = self.buttonColorSet.stateColors.disabledState.mainColor
        self.layer.borderColor = self.buttonColorSet.stateColors.disabledState.backlightColor

        self.layer.shadowColor = self.buttonColorSet.stateColors.disabledState.backlightColor
        self.layer.shadowOpacity = 0.3
    }

    func touchUp() {
        self.layer.backgroundColor = self.buttonColorSet.stateColors.enabledState.mainColor
        self.layer.borderColor = UIColor.white.cgColor.copy(alpha: 0.5)//self.buttonColorSet.stateColors.enabledState.backlightColor
        
        self.layer.shadowColor = self.buttonColorSet.stateColors.enabledState.backlightColor
        self.layer.shadowOpacity = 0.7
    }
}
