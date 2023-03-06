//
//  ActionsViewController.swift
//  Kuka Connector
//
//  Created by Пользователь on 11.01.2023.
//

import UIKit

class ChangeCoordController: UIViewController {
    @IBOutlet weak var x_LabelField: CoordLabel!
    @IBOutlet weak var y_LabelField: CoordLabel!
    @IBOutlet weak var z_LabelField: CoordLabel!
    @IBOutlet weak var A_LabelField: CoordLabel!
    @IBOutlet weak var B_LabelField: CoordLabel!
    @IBOutlet weak var C_LabelField: CoordLabel!
    
    @IBOutlet weak var x_TextField: UnderwrittenTextField!
    @IBOutlet weak var y_TextField: UnderwrittenTextField!
    @IBOutlet weak var z_TextField: UnderwrittenTextField!
    @IBOutlet weak var A_TextField: UnderwrittenTextField!
    @IBOutlet weak var B_TextField: UnderwrittenTextField!
    @IBOutlet weak var C_TextField: UnderwrittenTextField!
    
    @IBOutlet weak var disconnectButton: NeonButton!
    
    var robot: Openshowvar? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.disconnectButton.buttonColorSet = .purpleButton
        self.disconnectButton.buttonTextLabel = "ОТКЛЮЧИТЬСЯ"
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        self.refreshCoord()
        self.initCoordTextFields()
        self.disconnectButton.isEnabled = true
    }
    
    @IBAction func pressedRefreshButton(_ sender: Any) {
        self.refreshCoord()
    }
    
    func refreshCoord() {
        let cartessians = Kuka.read_cartenssian(robot: self.robot!)
        self.x_LabelField.text = String(cartessians.x_cartessian)
        self.y_LabelField.text = String(cartessians.y_cartessian)
        self.z_LabelField.text = String(cartessians.z_cartessian)
        self.A_LabelField.text = String(cartessians.A_cartessian)
        self.B_LabelField.text = String(cartessians.B_cartessian)
        self.C_LabelField.text = String(cartessians.C_cartessian)
    }
    
    func initCoordTextFields() {
        self.x_TextField.text = self.x_LabelField.text
        self.y_TextField.text = self.y_LabelField.text
        self.z_TextField.text = self.z_LabelField.text
        self.A_TextField.text = self.A_LabelField.text
        self.B_TextField.text = self.B_LabelField.text
        self.C_TextField.text = self.C_LabelField.text
    }
    
    @IBAction func disconnectButtonPressed(_ sender: Any) {
        self.disconnectButton.isEnabled = false
        robot?.sock?.closeSocket()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func writeButtonPressed(_ sender: Any) {
        var arr: [String] = []
        arr.append(x_TextField.text ?? "0.0")
        arr.append(y_TextField.text ?? "0.0")
        arr.append(z_TextField.text ?? "0.0")
        arr.append(A_TextField.text ?? "0.0")
        arr.append(B_TextField.text ?? "0.0")
        arr.append(C_TextField.text ?? "0.0")
        Kuka.ptp(robot: self.robot!, arr: arr)
        self.refreshCoord()
    }
}
