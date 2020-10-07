//
//  SettingsController.swift
//  Rick et Morty API
//
//  Created by Matthieu PASSEREL on 01/08/2018.
//  Copyright © 2018 Matthieu PASSEREL. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var statusSwitch: UISwitch!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwitch()
        setupNameLabel()
    }
    
    func setupSwitch() {
        statusSwitch.setOn(UserDefaultsHelper().getStatus(), animated: true)
        statusLbl.text = "Statut: " + UserDefaultsHelper().getStatusString()
    }
    
    func setupNameLabel() {
        let name = UserDefaultsHelper().getName()
        if name == "" {
            nameTF.placeholder = "Entrez un prénom"
        } else {
            nameTF.text = name
        }
    }
    
    
    @IBAction func SwitchChanged(_ sender: UISwitch) {
        UserDefaultsHelper().setStatus(bool: sender.isOn)
        setupSwitch()
    }    
    
    @IBAction func saveAction(_ sender: Any) {
        UserDefaultsHelper().setName(string: nameTF.text)
        navigationController?.popViewController(animated: true)
    }
}
