//
//  Post.swift
//  SocialNetwork
//
//  Created by Zvonimir Taslak on 18/07/16.
//  Copyright © 2016 Zvonimir Taslak. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Post {
    
    private var _postDescripton: String!
    private var _imageUrl: String?
    private var _likes: Int!
    private var _username: String!
    private var _postKey: String!
    private var _postRef: FIRDatabaseReference!
    
    
    var postDescription: String {
        return _postDescripton
    }
    var imageUrl: String? {
        return _imageUrl
    }
    var likes: Int {
        return _likes
    }
    var username: String {
        return _username
    }
    var postKey: String {
        return _postKey
    }
    
    init(description: String, imageUrl: String?, username: String){
        self._postDescripton = description
        self._imageUrl = imageUrl
        self._username = username
    }
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>){
        
        self._postKey = postKey
        
        if let likes = dictionary["likes"] as? Int {
            self._likes = likes
        }
        if let imageUrl = dictionary["imageURL"] as? String {
            self._imageUrl = imageUrl
        }
        if let desc = dictionary["description"] as? String {
            self._postDescripton = desc
        }
        self._postRef = DataService().posts.child(self._postKey)
    }
    
    func adjustLikes(addLike: Bool) {
    
        if addLike == true {
            _likes = _likes + 1
        } else {
            _likes = _likes - 1
        }
        
        _postRef.child("likes").setValue(_likes)
    }
}