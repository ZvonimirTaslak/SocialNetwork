//
//  DataService.swift
//  SocialNetwork
//
//  Created by Zvonimir Taslak on 13/07/16.
//  Copyright © 2016 Zvonimir Taslak. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DataService {
    
    private let _posts = FIRDatabase.database().referenceFromURL("https://socialnetwork-577f2.firebaseio.com/posts")
    private let _users = FIRDatabase.database().referenceFromURL("https://socialnetwork-577f2.firebaseio.com/users")

    var posts: FIRDatabaseReference {
        get {
            return _posts
        }
    
    }
    
    
    func createFirebaseUser(uid: String, user: Dictionary<String, String>) {
        _users.childByAppendingPath(uid).setValue(user)
    }
}