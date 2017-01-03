//
//  LanguageSelectionViewController.swift
//  BabyMilestones
//
//  Created by Luke Cheskin on 03/12/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit

class LanguageSelectionViewController: UIViewController {

    @IBOutlet var selectLanguageLabel: UILabel!
    @IBOutlet var backButton: CustomizableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let languageChoice = UserDefaults.standard.value(forKey: "language") as? String {
            if languageChoice == "English" {
                selectLanguageLabel.text = "Please choose a language"
                backButton.setTitle("Back", for: .normal)
            } else if languageChoice == "French" {
                selectLanguageLabel.text = "Veuillez choisir une langue"
                backButton.setTitle("Arrière", for: .normal)
            }
        }
        
    }
    
    
    @IBAction func languageSelectEnglish(_ sender: Any) {
        
        language = "English"
        selectLanguageLabel.text = "Please choose a language"
        backButton.setTitle("Back", for: .normal)
        UserDefaults.standard.set("English", forKey: "language")
        print("Selected Language: English")
        
    }
    
    @IBAction func languageSelectFrench(_ sender: Any) {
        
        language = "French"
        selectLanguageLabel.text = "Veuillez choisir une langue"
        backButton.setTitle("Arrière", for: .normal)
        UserDefaults.standard.set("French", forKey: "language")
        print("Selected Language: French")
        
    }
    
}
