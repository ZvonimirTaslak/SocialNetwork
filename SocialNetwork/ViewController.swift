//
//  ViewController.swift
//  SocialNetwork
//
//  Created by Zvonimir Taslak on 01/07/16.
//  Copyright © 2016 Zvonimir Taslak. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fbBtnPressed(sender: UIButton) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self) { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError:NSError!) -> Void in
            if facebookError != nil {
                print("facebook login fail\(facebookError)")
            } else {
                let accesToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Successfuli loggin in with facebook \(facebookResult)")
                print("\(accesToken)")
            }
        }
    }

}

