//
//  LoginViewController.swift
//  BabyMilestones
//
//  Created by Luke Cheskin on 06/11/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

var language = UserDefaults.standard.value(forKey: "language") as? String

class LoginViewController: UIViewController {

    @IBOutlet var backgroundViews: UIView!
    @IBOutlet var emailTextField: CustomizableTextField!
    @IBOutlet var passwordTextField: CustomizableTextField!
    @IBOutlet var loginButton: CustomizableButton!
    @IBOutlet var signupButton: CustomizableButton!
    @IBOutlet var forgotPasswordButton: CustomizableButton!
    @IBOutlet var languageButton: UIButton!
    let networkingService = NetworkingService()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
        if languageChoice == "English" {
            emailTextField.placeholder = "Email"
            passwordTextField.placeholder = "Password"
            loginButton.setTitle("Login", for: .normal)
            signupButton.setTitle("Don't have an account? Sign up!", for: .normal)
            forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
            languageButton.setImage(UIImage(named: "UK Flag"), for: UIControlState.normal)
        } else if languageChoice == "French" {
            emailTextField.placeholder = "Émail"
            passwordTextField.placeholder = "Mot de passe"
            loginButton.setTitle("S'identifier", for: .normal)
            signupButton.setTitle("Vous n'avez pas de compte? S'inscrire!", for: .normal)
            forgotPasswordButton.setTitle("Mot de passe oublié?", for: .normal)
            languageButton.setImage(UIImage(named: "French Flag"), for: UIControlState.normal)
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundViews.backgroundColor = UIColor.clear
        
        if language == "" {
            language = "English"
            print("No language detected")
        }
        
        UserDefaults.standard.set(language, forKey: "language")
        
        if let languageSelection = UserDefaults.standard.value(forKey: "language") as? String {
            print("Current Language: \(languageSelection)")
        }
    }
    
    @IBAction func unwindToLogIn(storyboard:UIStoryboardSegue) {
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if !isConnectedToNetwork() {
            // The user is not connected to the internet
            let alertController = SCLAlertView()
            alertController.addButton("Close", action: self.resultsNil)
            alertController.showError("Ooops!", subTitle: "It seems you're not connected to the internet.")
        } else {
            // The user is connected to the internet
            networkingService.signIn(email: emailTextField.text!, password: passwordTextField.text!)
        }
    }
    func resultsNil() {}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
