//
//  ActionsViewController.swift
//  Kuka Connector
//
//  Created by Пользователь on 11.01.2023.
//

import UIKit

class CoordActionsController: UIViewController {
    @IBOutlet weak var x_LabelField: CoordLabel!
    @IBOutlet weak var y_LabelField: CoordLabel!
    @IBOutlet weak var z_LabelField: CoordLabel!
    @IBOutlet weak var A_LabelField: CoordLabel!
    @IBOutlet weak var B_LabelField: CoordLabel!
    @IBOutlet weak var C_LabelField: CoordLabel!
    @IBOutlet weak var disconnectButton: NeonButton!
    //    @IBOutlet weak var readCartenssianButton: NeonButton!
//    @IBOutlet weak var writeCartenssianButton: NeonButton!
    
    var robot: Openshowvar? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.disconnectButton.buttonColorSet = .purpleButton
        self.disconnectButton.buttonTextLabel = "ОТКЛЮЧИТЬСЯ"
        
//        self.readCartenssianButton.buttonTextLabel = "Прочитать переменные"
//        self.writeCartenssianButton.buttonTextLabel = "Записать переменные"
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    @objc func readCartessianPressed(sender: UIButton!) {
        let cartessians = Kuka.read_cartenssian(robot: self.robot!)
    }
    
    @objc func setBasePressed(sender: UIButton!) {
        Kuka.set_base(robot: self.robot!, arr: [0,0,0,0,0,0])
    }
    
    @IBAction func pressedRefreshButton(_ sender: Any) {
//        let cartessians = Kuka.read_cartenssian(robot: self.robot!)
        self.x_LabelField.text = "1.1"//String(cartessians.x_cartessian)
        self.y_LabelField.text = "1.1"//String(cartessians.y_cartessian)
        self.z_LabelField.text = "1.1"//String(cartessians.z_cartessian)
        self.A_LabelField.text = "1.1"//String(cartessians.A_cartessian)
        self.B_LabelField.text = "1.1"//String(cartessians.B_cartessian)
        self.C_LabelField.text = "1.1"//String(cartessians.C_cartessian)
    }
    
    @IBAction func pressedSetBase(_ sender: Any) {
        var arr: [String] = []
        arr.append(x_LabelField.text ?? "0.0")
        arr.append(y_LabelField.text ?? "0.0")
        arr.append(z_LabelField.text ?? "0.0")
        arr.append(A_LabelField.text ?? "0.0")
        arr.append(B_LabelField.text ?? "0.0")
        arr.append(C_LabelField.text ?? "0.0")
        Kuka.ptp(robot: self.robot!, arr: arr)
    }
    
    @IBAction func disconnectButtonPressed(_ sender: Any) {
        self.disconnectButton.isEnabled = false
        sleep(1)
        navigationController?.popViewController(animated: true)
    }
    @IBAction func writeButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToChangeCoord", sender: nil)
    }
}
