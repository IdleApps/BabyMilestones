//
//  UpdateTableViewController.swift
//  BabyMilestones
//
//  Created by Luke Cheskin on 17/11/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class UpdateTableViewController: UITableViewController {

    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    var milestone: Milestone!
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        descriptionTextField.text = milestone.content
        nameTextField.text = milestone.title
        
    }
    
    
    @IBAction func updateMilestoneAction(_ sender: Any) {
        
        var userID: String!
        userID = FIRAuth.auth()?.currentUser?.uid
        
        var title = String()
        var content = String()
        
        if nameTextField.text != "" {
            // A milestone has been entered
            title = nameTextField.text!
        } else {
            // A milestone has not been entered
            nameTextField.text = "Default milestone name"
            title = nameTextField.text!
        }
        
        if descriptionTextField.text != "" {
            // A milestone description has been entered
            content = descriptionTextField.text!
        } else {
            // A milestone description has not been entered
            descriptionTextField.text = "Default milestone description"
            content = descriptionTextField.text!
        }
        
        let updatedMilestone = Milestone(title: title, content: content, uid: FIRAuth.auth()!.currentUser!.uid, red: milestone.red, blue: milestone.blue, green: milestone.green)
        
        let key = milestone.ref!.key
        
        let updateRef = databaseRef.child("users/" + userID + "/" + key)
        
        updateRef.updateChildValues(updatedMilestone.toAnyObject())
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
