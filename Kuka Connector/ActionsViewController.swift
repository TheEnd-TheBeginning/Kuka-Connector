//
//  ActionsViewController.swift
//  Kuka Connector
//
//  Created by Пользователь on 11.01.2023.
//

import UIKit

class ActionsViewController: UIViewController {
    @IBOutlet weak var ActionsBarButton: UIBarButtonItem!
    @IBOutlet weak var ActionsStackView: UIStackView!
    @IBOutlet weak var x_TextField: UITextField!
    @IBOutlet weak var y_TextField: UITextField!
    @IBOutlet weak var z_TextField: UITextField!
    @IBOutlet weak var A_TextField: UITextField!
    @IBOutlet weak var B_TextField: UITextField!
    @IBOutlet weak var C_TextField: UITextField!
    @IBOutlet weak var readCartessianButt: UIButton!
    @IBOutlet weak var writeCartessianButt: UIButton!
    var actionButtons: [KukaActions:UIButton] = [:]
    var robot: Openshowvar? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ActionsStackView.isHidden = true
        self.ActionsStackView.layer.cornerRadius = 10
        self.readCartessianButt.layer.cornerRadius = 10
        self.writeCartessianButt.layer.cornerRadius = 10
        self.setActionButtons()
        self.setStackView()
        self.initBase()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    func initBase() {
        self.x_TextField.text = "0.0"
        self.y_TextField.text = "0.0"
        self.z_TextField.text = "0.0"
        self.A_TextField.text = "0.0"
        self.B_TextField.text = "0.0"
        self.C_TextField.text = "0.0"
    }
    
    func setActionButtons() {
        for kukaAction in KukaActions.allCases {
            switch kukaAction {
            case .read_cartessian:
                let actionButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: ActionsStackView.frame.width, height: 50))
                actionButton.backgroundColor = .clear
                actionButton.setTitle(kukaAction.rawValue, for: .normal)
                actionButton.addTarget(self, action: #selector(readCartessianPressed), for: .touchUpInside)
                actionButton.isEnabled = false
                actionButtons[kukaAction] = actionButton
                print("read_cartessian")
            case .read_name:
                print("read_name")
            case .open_grip:
                print("open_grip")
            case .close_grip:
                print("close_grip")
            case .ptp:
                print("set_base")
                let actionButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: ActionsStackView.frame.width, height: 70))
                actionButton.backgroundColor = .clear
                actionButton.setTitle(kukaAction.rawValue, for: .normal)
                actionButton.addTarget(self, action: #selector(setBasePressed), for: .touchUpInside)
                actionButton.isEnabled = false
                actionButtons[kukaAction] = actionButton
            case .read_tcp_velocity:
                print("read_tcp_velocity")
            }
        }
    }
    
    @objc func readCartessianPressed(sender: UIButton!) {
        let cartessians = Kuka.read_cartenssian(robot: self.robot!)
    }
    
    @objc func setBasePressed(sender: UIButton!) {
        Kuka.set_base(robot: self.robot!, arr: [0,0,0,0,0,0])
    }
    
    @IBAction func pressedReadCartessian(_ sender: Any) {
        let cartessians = Kuka.read_cartenssian(robot: self.robot!)
        self.x_TextField.text = String(cartessians.x_cartessian)
        self.y_TextField.text = String(cartessians.y_cartessian)
        self.z_TextField.text = String(cartessians.z_cartessian)
        self.A_TextField.text = String(cartessians.A_cartessian)
        self.B_TextField.text = String(cartessians.B_cartessian)
        self.C_TextField.text = String(cartessians.C_cartessian)
    }
    
    @IBAction func pressedSetBase(_ sender: Any) {
        var arr: [String] = []
        arr.append(x_TextField.text ?? "0")
        arr.append(y_TextField.text ?? "0")
        arr.append(z_TextField.text ?? "0")
        arr.append(A_TextField.text ?? "0")
        arr.append(B_TextField.text ?? "0")
        arr.append(C_TextField.text ?? "0")
        Kuka.ptp(robot: self.robot!, arr: arr)
    }
    func setStackView() {
        for kukaAction in KukaActions.allCases {
            if (kukaAction == .read_cartessian || kukaAction == .ptp) {
                self.ActionsStackView.addArrangedSubview(self.actionButtons[kukaAction]!)
            }
        }
    }
    
    @IBAction func ActionsBarButtonPressed(_ sender: Any) {
//        let newKuka = Kuka.read_cartenssian(robot: self.robot!)
        for actionButton in ActionsStackView.arrangedSubviews {
            print((actionButton as! UIButton).isEnabled)
            (actionButton as! UIButton).isEnabled = !(actionButton as! UIButton).isEnabled
        }
        self.ActionsStackView.isHidden = !self.ActionsStackView.isHidden
    }
}
