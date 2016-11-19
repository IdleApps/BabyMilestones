//
//  MilestoneListNavigationController.swift
//  BabyMilestones
//
//  Created by Luke Cheskin on 09/11/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MilestoneListNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkifUserIsLoggedIn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkifUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            // No user is logged in
            print("No user logged in. Sending to the login page")
            present(self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as UIViewController, animated: true, completion: nil)
        }
    }
    
    
    
}
