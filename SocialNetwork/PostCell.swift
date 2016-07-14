//
//  PostCell.swift
//  SocialNetwork
//
//  Created by Zvonimir Taslak on 14/07/16.
//  Copyright © 2016 Zvonimir Taslak. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet var profile: UIImageView!
    @IBOutlet var showcaseImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func drawRect(rect: CGRect) {
        profile.layer.cornerRadius = profile.frame.size.width / 2
        profile.clipsToBounds = true
        
        showcaseImg.clipsToBounds = true
    }
}
