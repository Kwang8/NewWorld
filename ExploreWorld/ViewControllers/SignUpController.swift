//
//  SignUpController.swift
//  ExploreWorld_1.0
//
//  Created by Kevin W on 7/24/17.
//  Copyright © 2017 Kevin W. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
//import FirebaeDatabase
class SignUpController:UIViewController{
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var retypeEmailTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var retypePasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var one:String=""
    var two:String=""
    @IBAction func alreadyHaveAccPressed(_ sender: Any) {
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
}
}
     /*   switch usernameTextField.text {
        case nul:
            one="no username"
            two="please put in a username"
            error()
        default:
        let username=usernameTextField.text
            
        }
        
        
        switch emailTextField.text{
        case nul:
            one="no email"
            two="please put in a username"
            error()
        
        default:
        let email=emailTextField.text
        }
        
        
        
        switch retypeEmailTextField.text{
        case nul:
            one="no retyped email"
            two="please retype your email"
            error()
        case emailTextField.text:
        retypemail=emailTextField.text
        default:
        one="emails dont match"
        two="please retype your email"
        error()
            }
        
        
        
        switch passwordTextField.text.length{
        case nul:
            one="no password"
            two="please put in a password"
            error()
        case <6:
            one="password to short"
            two="please choose a longer password"
            default:
            password=passwordTextField.text
        }
        
        
        switch retypePasswordTextField.text{
        case nul:
            one="no retype password"
            two="please put in a username"
            error()
        case passwordTextField.text:
        retypePassword.text=passwordTextField.text
        default:
            one="passwords dont match"
            two="please re type your password"
        }

        
    func error(){
        let invalidMoneyAlert = UIAlertController(title: one, message: two, preferredStyle: UIAlertControllerStyle.alert)
        invalidMoneyAlert.addAction(UIAlertAction(title:"ok", style: UIAlertActionStyle.default,handler:nil))
        self.present(invalidMoneyAlert, animated:true,completion:nil)
    }
    
     Auth.auth().cr eateUserWithEmail(emailField!, password!, username!: { (user,error) in
    let userID: String = user!.uid
    let username: String = self.usernameTextField.text!
    let password: String = self.passworrdTextField.text!
    let email: String = self.emailTextField.text!
    })
    }*/
