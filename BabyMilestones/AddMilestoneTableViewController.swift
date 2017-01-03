//
//  AddMilestoneViewController.swift
//  BabyMilestones
//
//  Created by Luke Cheskin on 06/11/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

var date = ""

class AddMilestoneTableViewController: UIViewController {

    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var datePickerView: UIDatePicker!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextView!
    
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        datePickerView.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        date = formatter.string(from: datePickerView.date)
        print(date)
        
        if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
            if languageChoice == "English" {
                
                saveButton.title = "Save"
                self.title = "Create"
                nameTextField.placeholder = "Enter Milestone Name"
                descriptionTextField.text = "Enter Milestone Description"
                datePickerView.locale = Locale.current
                
            } else if languageChoice == "French" {
                
                saveButton.title = "Garder"
                self.title = "Créer"
                nameTextField.placeholder = "Entrez le nom du jalon"
                descriptionTextField.text = "Entrez jalon la description"
                datePickerView.locale = Locale.current
                
            }
        }
        
    }
    
    
    func datePickerChanged(sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        date = formatter.string(from: datePickerView.date)
        
        print("Selected date is: \(date)")
    }

    @IBAction func saveMilestoneAction(_ sender: Any) {
        
        var userID: String!
        userID = FIRAuth.auth()?.currentUser?.uid
        
        let milestoneRef = databaseRef.child("users/" + userID).childByAutoId()
        
        let red = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
        let blue = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
        let green = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
        
        var title = String()
        var content = String()
        
        if nameTextField.text != "" {
            // A milestone has been entered
            title = nameTextField.text!
        } else {
            // A milestone has not been entered
            
            if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
                if languageChoice == "English" {
                    
                    nameTextField.text = "Default milestone name"
                    title = nameTextField.text!
                    
                } else if languageChoice == "French" {
                    
                    nameTextField.text = "Nom jalon par défaut"
                    title = nameTextField.text!
                    
                }
            }
        }
        
        if descriptionTextField.text != "" {
            // A milestone description has been entered
            content = date + " - " + descriptionTextField.text!
        } else {
            // A milestone description has not been entered
            
            if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
            if languageChoice == "English" {
                
                descriptionTextField.text = "Default milestone description"
                content = date + " - " + descriptionTextField.text!
                
            } else if languageChoice == "French" {
                
                descriptionTextField.text = "La description jalon par défaut"
                content = date + " - " + descriptionTextField.text!
                
            }
        }
    }
        
        let milestone = Milestone(title: title, content: content, uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
        
        milestoneRef.setValue(milestone.toAnyObject())
        self.navigationController?.popToRootViewController(animated: true)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
