//
//  ResetPasswordViewController.swift
//  BabyMilestones
//
//  Created by Luke Cheskin on 06/11/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet var resetPasswordLabel: UILabel!
    @IBOutlet var emailTextField: CustomizableTextField!
    @IBOutlet var resetPasswordButton: CustomizableButton!
    @IBOutlet var backButton: CustomizableButton!
    
    let networkingService = NetworkingService()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
            if languageChoice == "English" {
                
                resetPasswordLabel.text = "Reset Password"
                emailTextField.placeholder = "Email"
                resetPasswordButton.setTitle("Reset Password", for: .normal)
                backButton.setTitle("Back", for: .normal)
                
            } else if languageChoice == "French" {
                
                resetPasswordLabel.text = "Réinitialiser le mot de passe"
                emailTextField.placeholder = "Émail"
                resetPasswordButton.setTitle("Réinitialiser le mot de passe", for: .normal)
                backButton.setTitle("Arrière", for: .normal)
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func resetPasswordAction(_ sender: Any) {
        if !isConnectedToNetwork() {
            // The user is not connected to the internet
            let alertController = SCLAlertView()
            alertController.addButton("Close", action: self.resultsNil)
            alertController.showError("Ooops!", subTitle: "It seems you're not connected to the internet.")
        } else {
            // The user is connected to the internet
            networkingService.resetPassword(email: emailTextField.text!)
        }
    }
    func resultsNil() {}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
