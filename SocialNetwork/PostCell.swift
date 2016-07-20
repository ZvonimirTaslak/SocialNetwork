//
//  PostCell.swift
//  SocialNetwork
//
//  Created by Zvonimir Taslak on 14/07/16.
//  Copyright © 2016 Zvonimir Taslak. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseDatabase

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var showcaseImg: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var likeBtn: UIImageView!
    
    var post: Post!
    var request: Request?
    var likeRef = FIRDatabaseReference()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(PostCell.likeTapper))
        tap.numberOfTapsRequired = 1
        likeBtn.addGestureRecognizer(tap)
        likeBtn.userInteractionEnabled = true
    }
    
    override func drawRect(rect: CGRect) {
        profile.layer.cornerRadius = profile.frame.size.width / 2
        profile.clipsToBounds = true
        
        showcaseImg.clipsToBounds = true
    }
    
    func configureCell(post: Post, img: UIImage?){
        self.post = post
        
        self.likeRef = DataService().REF_USER_COURENT.child("likes").child(post.postKey)
        

        self.descriptionText.text = post.postDescription
        self.likesLbl.text = "\(post.likes)"
        
        if post.imageUrl != nil {
            
            if img != nil {
                self.showcaseImg.image = img
            } else {
                request = Alamofire.request(.GET, post.imageUrl!).validate(contentType: ["image/*"]).response(completionHandler: {request, response, data, err in
                
                    if err == nil {
                        let img = UIImage(data: data!)!
                        self.showcaseImg.image = img
                        FeedController.imaheCache.setObject(img, forKey: self.post.imageUrl!)
                    }
                })
            }
            
        } else {
            self.showcaseImg.hidden = true
        }
        
        
        likeRef.observeSingleEventOfType(.Value, withBlock: {snapshot in
        
            if let doesNotExist = snapshot.value as? NSNull {
                self.likeBtn.image = UIImage(named: "dislike-1")
            } else {
                self.likeBtn.image = UIImage(named: "like-1")
            }
        })
        
    }
    
    func likeTapper() {
        print("like pressed")
        
        
        likeRef.observeSingleEventOfType(.Value, withBlock: {snapshot in
            
            if let doesNotExist = snapshot.value as? NSNull {
                self.likeBtn.image = UIImage(named: "like-1")
                self.post.adjustLikes(true)
                self.likeRef.setValue(true)
            } else {
                self.likeBtn.image = UIImage(named: "dislike-1")
                self.post.adjustLikes(false)
                self.likeRef.removeValue()
            }
        })
    

    }



    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
