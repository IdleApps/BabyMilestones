
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
                
                if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
                    if languageChoice == "English" {
                        
                        let alertController = SCLAlertView()
                        alertController.addButton("Close", action: self.resultsNil)
                        alertController.showError("Ooops!", subTitle: "It seems that account hasn't been found.")

                        
                    } else if languageChoice == "French" {
                        
                        let alertController = SCLAlertView()
                        alertController.addButton("Fermer", action: self.resultsNil)
                        alertController.showError("Ooops!", subTitle: "Il semble que le compte n'a pas été trouvé.")
                        
                    }
                }
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
                
                if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
                    if languageChoice == "English" {
                        
                        let alertController = SCLAlertView()
                        alertController.addButton("Help", action: self.clickedForHelpFromRegister)
                        alertController.addButton("Close", action: self.resultsNil)
                        alertController.showError("Ooops!", subTitle: "Somethings gone wrong. Click help for more info.")
                        
                    } else if languageChoice == "French" {
                        
                        let alertController = SCLAlertView()
                        alertController.addButton("Aidez-moi", action: self.clickedForHelpFromRegister)
                        alertController.addButton("Fermer", action: self.resultsNil)
                        alertController.showError("Ooops!", subTitle: "Quelque chose a mal tourné. Cliquez sur Aide pour plus d'informations.")
                        
                    }
                }
            } else {
                print("Account created successfully")
                UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
                
                let alertTimer = DispatchTime.now() + 1.0
                DispatchQueue.main.asyncAfter(deadline: alertTimer) {
                    
                    // The following code will activate after 1 seconds
                    
                    if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
                        if languageChoice == "English" {
                            
                            let alertController = SCLAlertView()
                            alertController.addButton("Close", action: self.resultsNil)
                            alertController.showSuccess("Welcome to BabyMilestones!", subTitle: "We're so glad you joined us! We've created some important milestones for you. Tap on one to edit it or create your own by pressing the + icon at the top. Don't forget to add the date and any other information that you'd like.\n\nHave fun!")
                            
                        } else if languageChoice == "French" {
                            
                            let alertController = SCLAlertView()
                            alertController.addButton("Fermer", action: self.resultsNil)
                            alertController.showSuccess("Bienvenue sur BabyMilestones!", subTitle: "Nous sommes si heureux que vous vous joigniez à nous! Nous avons créé des jalons importants pour vous. Appuyez sur un pour le modifier ou créer le vôtre en appuyant sur l'icône + en haut. N'oubliez pas d'ajouter la date et toute autre information que vous souhaitez.\n\nS'amuser!")
                            
                        }
                    }
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
                    
                    if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
                        if languageChoice == "English" {
                            
                            let milestone1 = Milestone(title: "Rolling over", content: "01/01/2016 - Click to edit", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                            milestoneRef.setValue(milestone1.toAnyObject())
                            
                        } else if languageChoice == "French" {
                            
                            let milestone1 = Milestone(title: "Rouler dessus", content: "01/01/2016 - Cliquez pour modifier", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                            milestoneRef.setValue(milestone1.toAnyObject())
                            
                        }
                    }
                    
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
                    
                    if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
                        if languageChoice == "English" {
                            
                            let milestone2 = Milestone(title: "First full sleep", content: "01/01/2016 - Click to edit", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                            milestoneRef.setValue(milestone2.toAnyObject())
                            
                        } else if languageChoice == "French" {
                            
                            let milestone2 = Milestone(title: "Premier sommeil complet", content: "01/01/2016 - Cliquez pour modifier!", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                            milestoneRef.setValue(milestone2.toAnyObject())
                            
                        }
                    }
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
                    
                    if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
                        if languageChoice == "English" {
                            
                            let milestone3 = Milestone(title: "First bath", content: "01/01/2016 - Click to edit", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                            milestoneRef.setValue(milestone3.toAnyObject())
                            
                        } else if languageChoice == "French" {
                            
                            let milestone3 = Milestone(title: "Premier bain", content: "01/01/2016 - Cliquez pour modifier", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                            milestoneRef.setValue(milestone3.toAnyObject())
                            
                        }
                    }
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
                    
                    if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
                        if languageChoice == "English" {
                            
                            let milestone4 = Milestone(title: "First smile", content: "01/01/2016 - Click to edit", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                            milestoneRef.setValue(milestone4.toAnyObject())

                            
                        } else if languageChoice == "French" {
                            
                            let milestone4 = Milestone(title: "Premier sourire", content: "01/01/2016 - Cliquez pour modifier", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                            milestoneRef.setValue(milestone4.toAnyObject())

                            
                        }
                    }
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
                    
                    if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
                        if languageChoice == "English" {
                            
                            let milestone5 = Milestone(title: "First steps", content: "01/01/2016 - Click to edit", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                            milestoneRef.setValue(milestone5.toAnyObject())
                            
                        } else if languageChoice == "French" {
                            
                            let milestone5 = Milestone(title: "Premiers pas", content: "01/01/2016 - Cliquez pour modifier", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                            milestoneRef.setValue(milestone5.toAnyObject())
                            
                        }
                    }
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
                    
                    if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
                        if languageChoice == "English" {
                            
                            let milestone6 = Milestone(title: "First tooth", content: "01/01/2016 - Click to edit", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                            milestoneRef.setValue(milestone6.toAnyObject())
                            
                        } else if languageChoice == "French" {
                            
                            let milestone6 = Milestone(title: "Première dent", content: "01/01/2016 - Cliquez pour modifier", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                            milestoneRef.setValue(milestone6.toAnyObject())
                            
                        }
                    }
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
                    
                    if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
                        if languageChoice == "English" {
                            
                            let milestone7 = Milestone(title: "First word", content: "01/01/2016 - Click to edit", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                            milestoneRef.setValue(milestone7.toAnyObject())
                            
                        } else if languageChoice == "French" {
                            
                            let milestone7 = Milestone(title: "Premier mot", content: "01/01/2016 - Cliquez pour modifier", uid: FIRAuth.auth()!.currentUser!.uid, red: red, blue: blue, green: green)
                            milestoneRef.setValue(milestone7.toAnyObject())
                            
                        }
                    }
                }
            }
        })
    }
    
    func resetPassword(email: String) {
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil {
                print("Password reset email was sent successfully")
                
                if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
                    if languageChoice == "English" {
                        
                        let alertController = SCLAlertView()
                        alertController.addButton("Close", action: self.resultsNil)
                        alertController.showSuccess("Success", subTitle: "A password reset email has been send to " + email)
                        
                    } else if languageChoice == "French" {
                        
                        let alertController = SCLAlertView()
                        alertController.addButton("Fermer", action: self.resultsNil)
                        alertController.showSuccess("Le succès", subTitle: "Un email de réinitialisation de mot de passe a été envoyé à " + email)
                    }
                }
                
            } else {
                print(error!)
                
                if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
                    if languageChoice == "English" {
                        
                        let alertController = SCLAlertView()
                        alertController.addButton("Help", action: self.clickedForHelpFromReset)
                        alertController.addButton("Close", action: self.resultsNil)
                        alertController.showError("Ooops!", subTitle: "Somethings gone wrong. Click help for more info.")
                        
                    } else if languageChoice == "French" {
                        
                        let alertController = SCLAlertView()
                        alertController.addButton("Aidez-moi", action: self.clickedForHelpFromReset)
                        alertController.addButton("Fermer", action: self.resultsNil)
                        alertController.showError("Ooops!", subTitle: "Quelque chose a mal tourné. Cliquez sur Aide pour plus d'informations.")
                        
                    }
                }
            }
        })
    }
    
    func resultsNil() {}
    
    func clickedForHelpFromRegister() {
        // The user has clicked the "Help" button
        
        if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
            if languageChoice == "English" {
                
                let alertController = SCLAlertView()
                alertController.addButton("Close", action: self.resultsNil)
                alertController.showInfo("Help", subTitle: "These are some reasons why you're getting this error\n\n • The email is already taken\n • The email is badly formatted\n • Some credentials are missing\n • The password must be more than 6 characters")
                
            } else if languageChoice == "French" {
                
                let alertController = SCLAlertView()
                alertController.addButton("Fermer", action: self.resultsNil)
                alertController.showInfo("Aidez-moi", subTitle: "Voici quelques raisons pour lesquelles vous recevez cette erreur\n\n • Le courriel est déjà pris\n • Le courriel est mal formaté\n • Certaines références sont manquantes\n • TLe mot de passe doit comporter plus de 6 caractères")
                
            }
        }
    }
    
    func clickedForHelpFromReset() {
        // The user has clicked the "Help button"
        
        if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
            if languageChoice == "English" {
                
                let alertController = SCLAlertView()
                alertController.addButton("Close", action: self.resultsNil)
                alertController.showInfo("Help", subTitle: "These are some reasons why you're getting this error\n\n • The email is badly formatted\n • The email isn't linked to an account")
                
            } else if languageChoice == "French" {
                
                let alertController = SCLAlertView()
                alertController.addButton("Fermer", action: self.resultsNil)
                alertController.showInfo("Aidez-moi", subTitle: "Voici quelques raisons pour lesquelles vous recevez cette erreur\n\n • TLe courriel est mal formaté\n • Le courriel n'est pas lié à un compte")
                
            }
        }
    }
}
