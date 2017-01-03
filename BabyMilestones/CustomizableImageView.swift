//
//  CustomizableImageView.swift
//  BabyMilestones
//
//  Created by Luke Cheskin on 06/11/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit

@IBDesignable class CustomizableImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}
