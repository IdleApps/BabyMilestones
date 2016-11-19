
//
//  NetworkingService.swift
//  BabyMilestones
//
//  Created by Luke Cheskin on 08/11/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import UIKit


struct NetworkingService {
    
    
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    
    private func saveInfo(user: FIRUser!, username: String, password: String){
        
        // Create our user dictionary info\
        
        let userInfo = ["email": user.email!, "username": username, "uid": user.uid]
        
        // create user reference
        
        let userRef = databaseRef.child("users").child(user.uid)
        
        // Save the user info in the Database
        
        userRef.setValue(userInfo)
        
        
        // Signing in the user
        signIn(email: user.email!, password: password)
        
    }
    
    private func setUserInfo(user: FIRUser!, username: String, password: String) {
        self.saveInfo(user: user, username: username, password: password)
    }
    
    
    // Step 2 - Logging the user in with an email and passwords
    func signIn(email: String, password: String) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error!)
                
                let alertController = SCLAlertView()
                alertController.addButton("Close", action: self.resultsNil)
                alertController.showError("Ooops!", subTitle: "It seems that account hasn't been found.")
            } else {
                var userUID: String!
                print("User logged in successfully")
                UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
                userUID = FIRAuth.auth()?.currentUser?.uid
                print(userUID)
            }
        })
        
    }
    
    func signUp(email: String, username: String, password: String){
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error!)
                
                let alertController = SCLAlertView()
                alertController.addButton("Help", action: self.clickedForHelpFromRegister)
                alertController.addButton("Close", action: self.resultsNil)
                alertController.showError("Ooops!", subTitle: "Somethings gone wrong. Click help for more info.")
                
            } else {
                print("Account created successfully")
                UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
                
                let alertTimer = DispatchTime.now() + 1.0
                DispatchQueue.main.asyncAfter(deadline: alertTimer) {
                    
                    // The following code will activate after 1 seconds
                    
                    let alertController = SCLAlertView()
                    alertController.addButton("Close", action: self.resultsNil)
                    alertController.showSuccess("Welcome to BabyMilestones!", subTitle: "We're so glad you joined us! We've created some important milestones for you. Tap on one to edit it or create your own by pressing the + icon at the top.\n\nHave fun!")
                }
                
                // Adding the default milestones to the user upon acount creation
                
                
                // Rolling over
                let milestone1Timer = DispatchTime.now() + 0.1
                DispatchQueue.main.asyncAfter(deadline: milestone1Timer) {
                    
                    var userID: String!
                    userID = FIRAuth.auth()?.currentUser?.uid
                    
                    // The following code will activate after 0.1 second
                    let red = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let blue = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let green = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let milestoneRef = self.databaseRef.child("users/" + userID).childByAutoId()
                    let milestone1 = Milestone(title: "Rolling over", content: "Click to edit", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                    milestoneRef.setValue(milestone1.toAnyObject())
                }
                
                // First full sleep
                let milestone2Timer = DispatchTime.now() + 0.2
                DispatchQueue.main.asyncAfter(deadline: milestone2Timer) {
                    
                    var userID: String!
                    userID = FIRAuth.auth()?.currentUser?.uid
                    
                    // The following code will activate after 0.2 second
                    let red = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let blue = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let green = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let milestoneRef = self.databaseRef.child("users/" + userID).childByAutoId()
                    let milestone2 = Milestone(title: "First full sleep", content: "Click to edit", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                    milestoneRef.setValue(milestone2.toAnyObject())
                }
                
                // First bath
                let milestone3Timer = DispatchTime.now() + 0.3
                DispatchQueue.main.asyncAfter(deadline: milestone3Timer) {
                    
                    var userID: String!
                    userID = FIRAuth.auth()?.currentUser?.uid
                    
                    // The following code will activate after 0.3 second
                    let red = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let blue = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let green = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let milestoneRef = self.databaseRef.child("users/" + userID).childByAutoId()
                    let milestone3 = Milestone(title: "First bath", content: "Click to edit", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                    milestoneRef.setValue(milestone3.toAnyObject())
                }
                
                // First smile
                let milestone4Timer = DispatchTime.now() + 0.4
                DispatchQueue.main.asyncAfter(deadline: milestone4Timer) {
                    
                    var userID: String!
                    userID = FIRAuth.auth()?.currentUser?.uid
                    
                    // The following code will activate after 0.4 second
                    let red = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let blue = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let green = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let milestoneRef = self.databaseRef.child("users/" + userID).childByAutoId()
                    let milestone4 = Milestone(title: "First smile", content: "Click to edit", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                    milestoneRef.setValue(milestone4.toAnyObject())
                }
                
                // First steps
                let milestone5Timer = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: milestone5Timer) {
                    
                    var userID: String!
                    userID = FIRAuth.auth()?.currentUser?.uid
                    
                    // The following code will activate after 0.5 second
                    let red = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let blue = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let green = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let milestoneRef = self.databaseRef.child("users/" + userID).childByAutoId()
                    let milestone5 = Milestone(title: "First steps", content: "Click to edit", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                    milestoneRef.setValue(milestone5.toAnyObject())
                }
                
                // First tooth
                let milestone6Timer = DispatchTime.now() + 0.6
                DispatchQueue.main.asyncAfter(deadline: milestone6Timer) {
                    
                    var userID: String!
                    userID = FIRAuth.auth()?.currentUser?.uid
                    
                    // The following code will activate after 0.6 second
                    let red = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let blue = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let green = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let milestoneRef = self.databaseRef.child("users/" + userID).childByAutoId()
                    let milestone6 = Milestone(title: "First tooth", content: "Click to edit", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                    milestoneRef.setValue(milestone6.toAnyObject())
                }
                
                // First word
                let milestone7Timer = DispatchTime.now() + 0.7
                DispatchQueue.main.asyncAfter(deadline: milestone7Timer) {
                    
                    var userID: String!
                    userID = FIRAuth.auth()?.currentUser?.uid
                    
                    // The following code will activate after 0.7 second
                    let red = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let blue = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let green = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
                    let milestoneRef = self.databaseRef.child("users/" + userID).childByAutoId()
                    let milestone7 = Milestone(title: "First word", content: "Click to edit", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                    milestoneRef.setValue(milestone7.toAnyObject())
                }
            }
        })
    }
    
    func resetPassword(email: String) {
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil {
                print("Password reset email was sent successfully")
                
                let alertController = SCLAlertView()
                alertController.addButton("Close", action: self.resultsNil)
                alertController.showSuccess("Success", subTitle: "A password reset email has been send to " + email)
                
            } else {
                print(error!)
                
                let alertController = SCLAlertView()
                alertController.addButton("Help", action: self.clickedForHelpFromReset)
                alertController.addButton("Close", action: self.resultsNil)
                alertController.showError("Ooops!", subTitle: "Somethings gone wrong. Click help for more info.")
                
            }
        })
    }
    
    func resultsNil() {}
    
    func clickedForHelpFromRegister() {
        // The user has clicked the "Help" button
        print("The user has clicked the HELP button")
        
        let alertController = SCLAlertView()
        alertController.addButton("Close", action: self.resultsNil)
        alertController.showInfo("Help", subTitle: "These are some reasons why you're getting this error\n\n • The email is already taken\n • The email is badly formatted\n • Some credentials are missing")
    }
    
    func clickedForHelpFromReset() {
        // The user has clicked the "Help button"
        print("The user has clicked the HELP button")
        
        let alertController = SCLAlertView()
        alertController.addButton("Close", action: self.resultsNil)
        alertController.showInfo("Help", subTitle: "These are some reasons why you're getting this error\n\n • The email is badly formatted\n • The email isn't linked to an account")
    }
}
