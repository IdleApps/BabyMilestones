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

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: CustomizableTextField!
    @IBOutlet var passwordTextField: CustomizableTextField!
    
    let networkingService = NetworkingService()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
