//
//  LoginViewController.swift
//  MDBSocial
//
//  Created by Nikita Ashok on 9/27/17.
//  Copyright © 2017 Nikita Ashok. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var appTitle: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var signupButton: UIButton!
    var background: UIImageView!
    var blurry: UILabel!

    override func viewDidLoad() {
        background = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        background.image = #imageLiteral(resourceName: "beach")
        background.alpha = 0.3
        background.contentMode = .scaleAspectFill
        view.addSubview(background)
        
        blurry = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        blurry.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.0)
        view.addSubview(blurry)
        
        //view.backgroundColor = UIColor(red: 216/255, green: 189/255, blue: 200/255, alpha: 1.0)
        super.viewDidLoad()
        
        
        setupTitle()
        setupTextFields()
        setupButtons()
        // Do any additional setup after loading the view.
        
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "toFeedFromLogin", sender: self)
        }
    }

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
            super.touchesBegan(touches, with: event)
        }
        //217.0f/255.0f green:234.0f/255.0f blue:211.0f/255
        func setupTitle() {
            appTitle = UILabel(frame: CGRect(x: 10, y: 10, width: UIScreen.main.bounds.width - 20, height: 0.3 * UIScreen.main.bounds.height))
            //appTitle.font = UIFont.systemFont(ofSize: 34, weight: 3)
            appTitle.adjustsFontSizeToFitWidth = true
            appTitle.textAlignment = .center
            appTitle.text = "MDB Social"
            appTitle.font = UIFont (name: "HelveticaNeue-Light", size: 50 )
            view.addSubview(appTitle)
        }
        
        func setupTextFields() {
            emailTextField = UITextField(frame: CGRect(x: 10, y: 0.3 * UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 20, height: 65))
            emailTextField.adjustsFontSizeToFitWidth = true
            emailTextField.placeholder = "Email"
            emailTextField.layoutIfNeeded()
            emailTextField.layer.borderColor = UIColor.lightGray.cgColor
            emailTextField.layer.borderWidth = 1.0
            emailTextField.layer.cornerRadius = 8
            emailTextField.backgroundColor = UIColor.white
            emailTextField.layer.masksToBounds = true
            emailTextField.textColor = UIColor.black
            self.view.addSubview(emailTextField)
            
            
            passwordTextField = UITextField(frame: CGRect(x: 10, y: 0.4 * UIScreen.main.bounds.height + 40, width: UIScreen.main.bounds.width - 20, height: 65))
            passwordTextField.adjustsFontSizeToFitWidth = true
            passwordTextField.placeholder = "Password"
            passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
            passwordTextField.layer.borderWidth = 1.0
            passwordTextField.layer.masksToBounds = true
            passwordTextField.layer.cornerRadius = 8
            passwordTextField.backgroundColor = UIColor.white
            passwordTextField.textColor = UIColor.black
            passwordTextField.isSecureTextEntry = true
            self.view.addSubview(passwordTextField)
        }
        //
        func setupButtons() {
            
            loginButton = UIButton(frame: CGRect(x: 10, y: 0.65 * UIScreen.main.bounds.height, width: 0.5 * UIScreen.main.bounds.width - 20, height: 30))
            loginButton.layoutIfNeeded()
            loginButton.setTitle("Log In", for: .normal)
            loginButton.setTitleColor(UIColor.black, for: .normal)
            loginButton.layer.borderWidth = 1.0
            loginButton.layer.cornerRadius = 3.0
            //loginButton.layer.borderColor = UIColor.blue.cgColor
            loginButton.layer.cornerRadius = 7
            loginButton.layer.opacity = 0.9
            loginButton.layer.masksToBounds = true
            loginButton.backgroundColor = UIColor(red: 163/255, green: 201/155, blue: 209/255, alpha: 1.0)
            loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
            self.view.addSubview(loginButton)
            
            signupButton = UIButton(frame: CGRect(x: 0.5 * UIScreen.main.bounds.width + 10, y: 0.65 * UIScreen.main.bounds.height, width: 0.5 * UIScreen.main.bounds.width - 20, height: 30))
            signupButton.layoutIfNeeded()
            signupButton.setTitle("Sign Up", for: .normal)
            signupButton.setTitleColor(UIColor.black, for: .normal)
            signupButton.layer.borderWidth = 1.0
            signupButton.layer.cornerRadius = 7.0
            //signupButton.layer.borderColor = UIColor.blue.cgColor
            signupButton.backgroundColor = UIColor(red: 163/255, green: 201/155, blue: 209/255, alpha: 1.0)
            signupButton.layer.masksToBounds = true
            signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
            self.view.addSubview(signupButton)
        }
        
        func loginButtonClicked(sender: UIButton!) {
            //TODO: Implement this function using Firebase calls!
            let email = emailTextField.text!
            emailTextField.text = ""
            let password = passwordTextField.text!
            passwordTextField.text = ""
            Auth.auth().signIn(withEmail: email, password: password, completion: { (User, error) in
                if error == nil {
                    self.performSegue(withIdentifier: "toFeedFromLogin", sender: self)
                }
            })
            
        }
        
        func signupButtonClicked(sender: UIButton!) {
            performSegue(withIdentifier: "toSignup", sender: self)
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
}
