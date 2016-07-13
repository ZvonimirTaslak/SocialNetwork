//
//  MaterialButton.swift
//  SocialNetwork
//
//  Created by Zvonimir Taslak on 01/07/16.
//  Copyright © 2016 Zvonimir Taslak. All rights reserved.
//

import UIKit

class MaterialButton: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        layer.shadowOpacity = 8.0
        layer.shadowRadius = 0.5
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
        
        
    }
}
