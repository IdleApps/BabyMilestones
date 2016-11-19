//
//  MilestoneTableViewController.swift
//  BabyMilestones
//
//  Created by Luke Cheskin on 10/11/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MilestoneTableViewController: UITableViewController {

    var milestoneArray = [Milestone]()
    var databaseRef: FIRDatabaseReference!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        var userID: String!
        userID = FIRAuth.auth()?.currentUser?.uid
        
        if userID == nil {
            print("userID is equal to nil")
            return
        }
        
        let databaseRef = FIRDatabase.database().reference().child("users/" + userID)
        
        
        databaseRef.observe(.value, with: { (snapshot) in
            
            var newMilestones = [Milestone]()
            
            for item in snapshot.children {
                
                let newMilestone = Milestone(snapshot: item as! FIRDataSnapshot)
                newMilestones.insert(newMilestone, at: 0)
                
            }
            self.milestoneArray = newMilestones
            self.tableView.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
            print("Timer of 5 seconds exceeded (viewWILLAppear)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad")
        
        var userID: String!
        userID = FIRAuth.auth()?.currentUser?.uid
        
        if userID == nil {
            print("userID is equal to nil")
            return
        }
        
        let databaseRef = FIRDatabase.database().reference().child("users/" + userID)
        
        
        databaseRef.observe(.value, with: { (snapshot) in
            
            var newMilestones = [Milestone]()
            
            for item in snapshot.children {
                
                let newMilestone = Milestone(snapshot: item as! FIRDataSnapshot)
                newMilestones.insert(newMilestone, at: 0)
                
            }
            self.milestoneArray = newMilestones
            self.tableView.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
            print("User successfully logged out")
            self.present(self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as UIViewController, animated: true, completion: nil)
        } catch let error {
            print(error)
        }

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return milestoneArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MilestoneTableViewCell

        cell.milestoneNameTextField.text = milestoneArray[indexPath.row].title
        cell.milestoneDescriptionTextField.text = milestoneArray[indexPath.row].content
        cell.colourView.backgroundColor = UIColor(red: milestoneArray[indexPath.row].red, green: milestoneArray[indexPath.row].green, blue: milestoneArray[indexPath.row].blue, alpha: 1.0)
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let ref = milestoneArray[indexPath.row].ref
            ref!.removeValue()
            milestoneArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "updateMilestone", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "updateMilestone" {
            let VC = segue.destination as! UpdateTableViewController
            let indexPath = tableView.indexPathForSelectedRow!
            
            VC.milestone = milestoneArray[indexPath.row]
            
        }
        
    }
    
}
