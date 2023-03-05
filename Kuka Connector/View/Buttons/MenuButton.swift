//
//  MenuButton.swift
//  Kuka Connector
//
//  Created by Пользователь on 05.03.2023.
//

import UIKit

class ActionsMenuButton: SimpleButton {
    var actionsStackView: UIStackView?
    var actionButtons: [KukaVariablesEnum: UIButton] = [:]
    var delegate: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let stackViewFrame = CGRect(x: self.bounds.minX, y: self.bounds.maxY, width: self.bounds.width, height: self.bounds.height * CGFloat(KukaVariablesEnum.allCases.count))
        self.actionsStackView = UIStackView(frame: stackViewFrame)
        self.setActionButtons()
        self.setStackView()
        
        self.delegate?.view.addSubview(self.actionsStackView!)
        self.delegate?.view.bringSubviewToFront(self.actionsStackView!)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

//функции для выпадающего списка
extension ActionsMenuButton {
    
    func setStackView() {
        for kukaVariable in KukaVariablesEnum.allCases {
            self.actionsStackView?.addArrangedSubview(self.actionButtons[kukaVariable]!)
        }
    }
    
    func setActionButtons() {
        for kukaVariable in KukaVariablesEnum.allCases {
            let actionButton: UIButton = SimpleButton(frame: CGRect(x: self.bounds.minX, y: 0, width: self.bounds.width, height: self.bounds.height))
            actionButton.setTitle(kukaVariable.rawValue, for: .normal)
            self.actionButtons[kukaVariable] = actionButton
        }
    }
    
//    func setActionButtons() {
//        for kukaAction in KukaActions.allCases {
//            switch kukaAction {
//            case .read_cartessian:
//                let actionButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: actionsStackView!.frame.width, height: 50))
//                actionButton.backgroundColor = .clear
//                actionButton.setTitle(kukaAction.rawValue, for: .normal)
//                actionButton.addTarget(self, action: #selector(readCartessianPressed), for: .touchUpInside)
//                actionButton.isEnabled = false
//                self.actionButtons[kukaAction] = actionButton
//                print("read_cartessian")
//            case .read_name:
//                print("read_name")
//            case .open_grip:
//                print("open_grip")
//            case .close_grip:
//                print("close_grip")
//            case .ptp:
//                print("set_base")
//                let actionButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: actionsStackView!.frame.width, height: 70))
//                actionButton.backgroundColor = .clear
//                actionButton.setTitle(kukaAction.rawValue, for: .normal)
//                actionButton.addTarget(self, action: #selector(setBasePressed), for: .touchUpInside)
//                actionButton.isEnabled = false
//                actionButtons[kukaAction] = actionButton
//            case .read_tcp_velocity:
//                print("read_tcp_velocity")
//            }
//        }
//    }
//
//    @objc func readCartessianPressed(sender: UIButton!) {
//        let cartessians = Kuka.read_cartenssian(robot: self.robot!)
//    }
//
//    @objc func setBasePressed(sender: UIButton!) {
//        Kuka.set_base(robot: self.robot!, arr: [0,0,0,0,0,0])
//    }
    
}
