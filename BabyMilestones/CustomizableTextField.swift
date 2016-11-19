//
//  CustomizableTextField.swift
//  BabyMilestones
//
//  Created by Luke Cheskin on 06/11/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit

@IBDesignable class CustomizableTextField: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
}
