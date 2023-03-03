//
//  ActionsViewController.swift
//  Kuka Connector
//
//  Created by Пользователь on 11.01.2023.
//

import UIKit

class ActionsViewController: UIViewController {
    @IBOutlet weak var x_TextField: UnderwrittenTextField!
    @IBOutlet weak var y_TextField: UnderwrittenTextField!
    @IBOutlet weak var z_TextField: UnderwrittenTextField!
    @IBOutlet weak var A_TextField: UnderwrittenTextField!
    @IBOutlet weak var B_TextField: UnderwrittenTextField!
    @IBOutlet weak var C_TextField: UnderwrittenTextField!
    @IBOutlet weak var disconnectButton: NeonButton!
    @IBOutlet weak var readCartenssianButton: NeonButton!
    @IBOutlet weak var writeCartenssianButton: NeonButton!
    
    var actionButtons: [KukaActions:UIButton] = [:]
    var robot: Openshowvar? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.disconnectButton.buttonColorSet = .purpleButton
        self.disconnectButton.buttonTextLabel = "ОТКЛЮЧИТЬСЯ"
        
        self.readCartenssianButton.buttonTextLabel = "Прочитать переменные"
        self.writeCartenssianButton.buttonTextLabel = "Записать переменные"
        
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
    
    @IBAction func disconnectButtonPressed(_ sender: Any) {
        self.disconnectButton.isEnabled = false
        sleep(1)
        navigationController?.popViewController(animated: true)
    }
}
