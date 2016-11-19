//
//  ResetPasswordViewController.swift
//  BabyMilestones
//
//  Created by Luke Cheskin on 06/11/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet var emailTextField: CustomizableTextField!
    
    let networkingService = NetworkingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
