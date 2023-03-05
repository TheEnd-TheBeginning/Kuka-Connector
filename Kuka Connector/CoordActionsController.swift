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
    
    var robot: Openshowvar? = nil
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.refreshCoord()
        self.disconnectButton.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.disconnectButton.buttonColorSet = .purpleButton
        self.disconnectButton.buttonTextLabel = "ОТКЛЮЧИТЬСЯ"
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
        robot?.sock?.closeSocket()
        navigationController?.popViewController(animated: true)
    }
    @IBAction func writeButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToChangeCoord", sender: nil)
    }
}
