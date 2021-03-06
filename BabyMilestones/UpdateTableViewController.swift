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

var dateResults = ""

class UpdateTableViewController: UIViewController {

    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    var milestone: Milestone!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var datePickerView: UIDatePicker!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        date = formatter.string(from: datePickerView.date)
        dateResults = date
        print(dateResults)
        
        if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
            if languageChoice == "English" {
                
                saveButton.title = "Save"
                self.title = "Update"
                nameTextField.placeholder = "Enter Milestone Name"
                datePickerView.locale = Locale.current
                
            } else if languageChoice == "French" {
                
                saveButton.title = "Garder"
                self.title = "Mettre à jour"
                nameTextField.placeholder = "Entrez le nom du jalon"
                datePickerView.locale = Locale.current
                
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        datePickerView.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        
        nameTextField.text = milestone.title
        descriptionTextField.text = milestone.content
        print("1: " + descriptionTextField.text)
        
        // Getting the date
        let dates = descriptionTextField.text!
        let dateResult = String(dates.characters.prefix(10))
        print(dateResult)
        print("2: " + descriptionTextField.text)
        
        // Getting the description
        var desc = descriptionTextField.text!
        let descCharacterLength = desc.characters.count-13
        let descResult = String(desc.characters.suffix(descCharacterLength))
        descriptionTextField.text! = descResult
        print("3: " + descriptionTextField.text)
        print("descResult: " + descResult)
        
        // Applying the date to the UIDatePicker
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateFromString = dateFormatter.date(from: dateResult)
        datePickerView.setDate(dateFromString!, animated: true)
        print("4: " + descriptionTextField.text)
    }
    
    func datePickerChanged(sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        date = formatter.string(from: datePickerView.date)
        dateResults = date
        print("Selected date is: \(date)")
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
            content = dateResults + " - " + descriptionTextField.text!
            print(content)
        } else {
            // A milestone description has not been entered
            if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
                if languageChoice == "English" {
                    
                    descriptionTextField.text = "Default milestone description"
                    content = dateResults + " - " + descriptionTextField.text!
                    
                } else if languageChoice == "French" {
                    
                    descriptionTextField.text = "La description jalon par défaut"
                    content = dateResults + " - " + descriptionTextField.text!
                    print("French")
                    
                }
            }

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
