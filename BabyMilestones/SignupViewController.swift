//
//  SignupViewController.swift
//  BabyMilestones
//
//  Created by Luke Cheskin on 06/11/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignupViewController: UIViewController {

    @IBOutlet var backgroundViews: UIView!
    @IBOutlet var usernameTextField: CustomizableTextField!
    @IBOutlet var emailTextField: CustomizableTextField!
    @IBOutlet var passwordTextField: CustomizableTextField!
    @IBOutlet var signupButton: CustomizableButton!
    @IBOutlet var backButton: CustomizableButton!
    
    let networkingService = NetworkingService()
    
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
            if languageChoice == "English" {
                
                usernameTextField.placeholder = "Name"
                emailTextField.placeholder = "Email"
                passwordTextField.placeholder = "Password"
                signupButton.setTitle("Sign up!", for: .normal)
                backButton.setTitle("Back", for: .normal)
                
            } else if languageChoice == "French" {
                
                usernameTextField.placeholder = "Nom"
                emailTextField.placeholder = "Émail"
                passwordTextField.placeholder = "Mot de passe"
                signupButton.setTitle("S'inscrire!", for: .normal)
                backButton.setTitle("Arrière", for: .normal)
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backgroundViews.backgroundColor = UIColor.clear
    }
    
    
    @IBAction func signUpAction(_ sender: Any) {
        if !isConnectedToNetwork() {
            // The user is not connected to the internet
            let alertController = SCLAlertView()
            alertController.addButton("Close", action: self.resultsNil)
            alertController.showError("Ooops!", subTitle: "It seems you're not connected to the internet.")
        } else {
            // The user is connected to the internet
            networkingService.signUp(email: emailTextField.text!, username: usernameTextField.text!, password: passwordTextField.text!)
        }
    }
    func resultsNil() {}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
