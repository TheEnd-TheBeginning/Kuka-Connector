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
    @IBOutlet weak var kukaImageView: UIImageView!
    var robot: Openshowvar = Openshowvar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = ""
        self.connectButton.layer.cornerRadius = 10
//        self.disconnectButton.layer.cornerRadius = 10
//        self.disconnectButton.isEnabled = false
        self.ipInput.delegate = self
        self.portInput.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        let kukaImage = UIImage(named: "kuka_silhouette")?.withTintColor(.black, renderingMode: .alwaysTemplate)
        self.kukaImageView.image = kukaImage
    }
    
    func changeKukaImage() -> Timer {
//        var animationSec = 0
        let kukaImage = UIImage(named: "kuka_silhouette")?.withTintColor(.black, renderingMode: .alwaysTemplate)
//        self.kukaImageView.image = kukaImage
//        DispatchQueue.global(qos: .userInteractive).async {
            let animationTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
//                animationSec += 1
//                print("animation sec: \(animationSec)")
                self.kukaImageView.image = self.kukaImageView.image?.withHorizontallyFlippedOrientation()
            }
//        }
        return animationTimer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToActions" {
            if let destination = segue.destination as? ActionsViewController {
                destination.robot = self.robot
            }
        }
    }
    
    @IBAction func connectButtonPressed(_ sender: Any) {
        let animationTimer = self.changeKukaImage()
        self.connectButton.isEnabled = false
        self.ipInput.resignFirstResponder()
        self.portInput.resignFirstResponder()
        if (ipInput.text != "" && ipInput.text != nil) {
            if (portInput.text != nil && portInput.text != "") {
                if let intPort = Int(portInput.text!) {
                    let uint16port: UInt16 = UInt16(intPort)
//                    self.robot = Openshowvar(ip: ipInput.text!, port: uint16port)
                    let ipInputText: String = self.ipInput.text!
                    DispatchQueue.global(qos: .userInitiated).async {
                        let can_connect = self.robot.connect(ip: ipInputText, port: uint16port)
                        if can_connect {
                            animationTimer.invalidate()
    //                        self.disconnectButton.isEnabled = true
    //                        viewModel.read_cartenssian()
    //                        self.presentAlert(title: "Сообщение", message: "Подключение прошло успешно")
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "goToActions", sender: nil)
                            }
                        } else {
                            animationTimer.invalidate()
                            print("Connection error")
                            DispatchQueue.main.async {
                                self.connectButton.isEnabled = true
                                self.presentAlert(title: "Сообщение", message: "Ошибка подключения")
                            }
                        }
                    }
                } else {
                    self.connectButton.isEnabled = true
                    self.presentAlert(title: "Сообщение", message: "Порт должен быть числом")
                }
            } else {
                self.connectButton.isEnabled = true
                self.presentAlert(title: "Сообщение", message: "Заполните поле \"Порт\"")
            }
        } else {
            self.connectButton.isEnabled = true
            self.presentAlert(title: "Сообщение", message: "Заполните поле \"ip\"")
        }
    }
    
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

