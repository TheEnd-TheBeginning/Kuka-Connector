//
//  ViewController.swift
//  Kuka Connector
//
//  Created by Пользователь on 10.01.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var portInput: UITextField!
    @IBOutlet weak var ipInput: UITextField!
    var robot: Openshowvar? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = ""
        self.connectButton.layer.cornerRadius = 10
//        self.disconnectButton.layer.cornerRadius = 10
//        self.disconnectButton.isEnabled = false
        self.ipInput.delegate = self
        self.portInput.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToActions" {
            if let destination = segue.destination as? ActionsViewController {
                destination.robot = self.robot
            }
        }
    }
    
    @IBAction func connectButtonPressed(_ sender: Any) {
        let intPort = Int(portInput.text!)
        let uint16port: UInt16 = UInt16(intPort!)
        self.robot = Openshowvar(ip: ipInput.text!, port: uint16port)
        if self.robot!.can_connect {
//            self.disconnectButton.isEnabled = true
//                        viewModel.read_cartenssian()
//                        self.presentAlert(title: "Сообщение", message: "Подключение прошло успешно")
            performSegue(withIdentifier: "goToActions", sender: nil)
        }
    }
    
    
}

