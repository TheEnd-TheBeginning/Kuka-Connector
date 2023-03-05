//
//  ViewController.swift
//  Kuka Connector
//
//  Created by Пользователь on 10.01.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var connectButton: NeonButton!
    @IBOutlet weak var portInput: UnderwrittenTextField!
    @IBOutlet weak var ipInput: UnderwrittenTextField!
    var robot: Openshowvar = Openshowvar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.connectButton.buttonColorSet = .purpleButton
        self.connectButton.buttonTextLabel = "ПОДКЛЮЧИТЬСЯ"
        self.navigationItem.backButtonTitle = ""
//        self.tryIpInput.becomeFirstResponder()
//        self.ipInput.resignFirstResponder()
//        self.portInput.resignFirstResponder()
        
        self.ipInput.delegate = self
        self.portInput.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToActions" {
            if let destination = segue.destination as? CoordActionsController {
                destination.robot = self.robot
            }
        }
    }
    
    
    @IBAction func connectButtonPressed(_ sender: Any) {
        self.connectButton.isEnabled = false
        sleep(1)
        self.performSegue(withIdentifier: "goToActions", sender: nil)
    }
    
//    @IBAction func connectButtonPressed(_ sender: Any) {
//        self.connectButton.isEnabled = false
//        self.ipInput.resignFirstResponder()
//        self.portInput.resignFirstResponder()
//        if (ipInput.text != "" && ipInput.text != nil) {
//            if (portInput.text != nil && portInput.text != "") {
//                if let intPort = Int(portInput.text!) {
//                    let uint16port: UInt16 = UInt16(intPort)
////                    self.robot = Openshowvar(ip: ipInput.text!, port: uint16port)
//                    let ipInputText: String = self.ipInput.text!
//                    DispatchQueue.global(qos: .userInitiated).async {
//                        let can_connect = self.robot.connect(ip: ipInputText, port: uint16port)
//                        if can_connect {
//    //                        self.disconnectButton.isEnabled = true
//    //                        viewModel.read_cartenssian()
//    //                        self.presentAlert(title: "Сообщение", message: "Подключение прошло успешно")
//                            DispatchQueue.main.async {
//                                self.performSegue(withIdentifier: "goToActions", sender: nil)
//                            }
//                        } else {
//                            print("Connection error")
//                            DispatchQueue.main.async {
////                                self.connectButton.isEnabled = true
//                                self.presentAlert(title: "Сообщение", message: "Ошибка подключения")
//                            }
//                        }
//                    }
//                } else {
////                    self.connectButton.isEnabled = true
//                    self.presentAlert(title: "Сообщение", message: "Порт должен быть числом")
//                }
//            } else {
////                self.connectButton.isEnabled = true
//                self.presentAlert(title: "Сообщение", message: "Заполните поле \"Порт\"")
//            }
//        } else {
////            self.connectButton.isEnabled = true
//            self.presentAlert(title: "Сообщение", message: "Заполните поле \"ip\"")
//        }
//    }
    
//    @IBAction func disconnectButtonPressed(_ sender: Any) {
//        viewModel.robot.sock.closeSocket()
//        self.presentAlert(title: "Сообщение", message: "Вы отключились")
//        self.connectButton.isEnabled = true
//        self.disconnectButton.isEnabled = false
//    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) {
            UIAlertAction in NSLog("Cancel Pressed")
        })
        self.present(alert, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

