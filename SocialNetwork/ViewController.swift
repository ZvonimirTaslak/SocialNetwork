//
//  ViewController.swift
//  SocialNetwork
//
//  Created by Zvonimir Taslak on 01/07/16.
//  Copyright © 2016 Zvonimir Taslak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FBSDKLoginKit
import FBSDKCoreKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.password.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
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
                
        
                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(accesToken)
                FIRAuth.auth()?.signInWithCredential(credential, completion: { (authData, error) in
                    if error != nil {
                        print("Login faild \(error)")
                    } else {
                        print("Logged in \(authData)")
                        
                        let user = ["provider": authData!.providerID, "blah" : "test"]
                        DataService().createFirebaseUser(authData!.uid, user: user)
                        
                        NSUserDefaults.standardUserDefaults().setValue(authData!.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    }
                })
            }
        }
    }
    
    @IBAction func attemptLogin(sender: UIButton!){
        
        
        if let email = emailField.text where email != "", let pwd = password.text where pwd != "" {
        
            FIRAuth.auth()?.signInWithEmail(email, password: pwd, completion: { (authdata, error) in
                if error != nil {
                    print(error!.code)
                    if error!.code == STATUS_ACCOUNT_NONEXIST || error!.code == STATUS_USER_NOT_FOUND{
                      FIRAuth.auth()?.createUserWithEmail(email, password: pwd, completion: { (authData, error) in
                        if error != nil {
                            self.showErrorAlert("Could not create account", msg: "problem creating account, try something else")
                            print("Create user faild \(error)")

                        } else {
                            NSUserDefaults.standardUserDefaults().setValue(authData?.uid, forKey: KEY_UID)
                          //  FIRAuth.auth()?.signInWithEmail(email, password: pwd, completion: nil)
                            
                            FIRAuth.auth()?.signInWithEmail(email, password: pwd, completion: { (authData, error) in
                                
                                let user = ["provider": authData!.providerID, "blah" : "email test"]
                                DataService().createFirebaseUser(authData!.uid, user: user)
                                
                            })
                           
                            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                        }
                      })
                    } else {
                        self.showErrorAlert("Could not login", msg: "Please check your username or password")
                    }
                } else {
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                }
            })
            
            
        } else {
            showErrorAlert("Email and Password Required", msg: "You must enter an email and a password")
        }
    }

    func showErrorAlert(title: String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok!", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
}

