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

    @IBOutlet var usernameTextField: CustomizableTextField!
    @IBOutlet var emailTextField: CustomizableTextField!
    @IBOutlet var passwordTextField: CustomizableTextField!
    
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    let networkingService = NetworkingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
