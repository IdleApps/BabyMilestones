//
//  MilestoneTableViewCell.swift
//  BabyMilestones
//
//  Created by Luke Cheskin on 11/11/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit

class MilestoneTableViewCell: UITableViewCell {
    
    
    @IBOutlet var milestoneNameTextField: UILabel!
    @IBOutlet var milestoneDescriptionTextField: UITextView!
    @IBOutlet var colourView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        milestoneDescriptionTextField.backgroundColor = UIColor(white: 1, alpha: 0.5)
        colourView.layer.cornerRadius = 15
        
    }
}
