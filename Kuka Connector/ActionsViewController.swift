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
    var robot: Openshowvar? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ActionsStackView.isHidden = true
    }
    
    @IBAction func ActionsBarButtonPressed(_ sender: Any) {
        let newKuka = Kuka.read_cartenssian(robot: self.robot!)
    }
}
