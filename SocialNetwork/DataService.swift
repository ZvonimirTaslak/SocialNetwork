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
    static let ds  = DataService()
    
    private var _REF_BASE = FIRDatabase.database().reference() //(url: "https://socialnetwork-577f2.firebaseio.com/")
    
    var REF_BASE:  FIRDatabaseReference {
        return _REF_BASE
    }
}