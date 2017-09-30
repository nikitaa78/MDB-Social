//
//  SignUpViewController.swift
//  MDBSocial
//
//  Created by Nikita Ashok on 9/27/17.
//  Copyright © 2017 Nikita Ashok. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var nameTextField: UITextField!
    //var profileImageView: UIImageView!
    var signupButton: UIButton!
    var goBackButton: UIButton!
    var selectFromLibraryButton: UIButton!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 151/255, green: 206/255, blue: 199/255, alpha: 1.0)
        
        // Do any additional setup after loading the view.
        setupTextFields()
        setupButtons()
        //setupProfileImageView()
        picker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*func setupProfileImageView() {
        profileImageView = UIImageView(frame: CGRect(x: 20, y: 20, width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width - 40))
        selectFromLibraryButton = UIButton(frame: profileImageView.frame)
        selectFromLibraryButton.setTitle("Pick Image From Library", for: .normal)
        selectFromLibraryButton.setTitleColor(UIColor.blue, for: .normal)
        selectFromLibraryButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        view.addSubview(profileImageView)
        view.addSubview(selectFromLibraryButton)
        view.bringSubview(toFront: selectFromLibraryButton)
        
    }*/
    
    func pickImage(sender: UIButton!) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func setupTextFields() {
        emailTextField = UITextField(frame: CGRect(x: 10, y: 0.6 * UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 20, height: 30))
        emailTextField.layer.cornerRadius = 8
        emailTextField.backgroundColor = UIColor.white
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.placeholder = "Email"
        emailTextField.layoutIfNeeded()
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.masksToBounds = true
        emailTextField.textColor = UIColor.black
        self.view.addSubview(emailTextField)
        
        
        passwordTextField = UITextField(frame: CGRect(x: 10, y: 0.6 * UIScreen.main.bounds.height + 40, width: UIScreen.main.bounds.width - 20, height: 30))
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.masksToBounds = true
        passwordTextField.textColor = UIColor.black
        passwordTextField.isSecureTextEntry = true
        self.view.addSubview(passwordTextField)
        
        nameTextField = UITextField(frame: CGRect(x: 10, y: 0.6 * UIScreen.main.bounds.height + 80, width: UIScreen.main.bounds.width - 20, height: 30))
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.layer.cornerRadius = 8
        nameTextField.backgroundColor = UIColor.white
        nameTextField.placeholder = "Name"
        nameTextField.layer.borderColor = UIColor.lightGray.cgColor
        nameTextField.layer.borderWidth = 1.0
        nameTextField.layer.masksToBounds = true
        nameTextField.textColor = UIColor.black
        self.view.addSubview(nameTextField)
    }
    
    func setupButtons() {
        
        signupButton = UIButton(frame: CGRect(x: 10, y: 0.8 * UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 20, height: 30))
        signupButton.layoutIfNeeded()
        signupButton.backgroundColor = UIColor.white
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.setTitleColor(UIColor.blue, for: .normal)
        signupButton.layer.borderWidth = 2.0
        signupButton.layer.cornerRadius = 3.0
        signupButton.layer.borderColor = UIColor.blue.cgColor
        signupButton.layer.masksToBounds = true
        signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        self.view.addSubview(signupButton)
        
        goBackButton = UIButton(frame: CGRect(x: 10, y: 0.8 * UIScreen.main.bounds.height + 40, width: UIScreen.main.bounds.width - 20, height: 30))
        goBackButton.layoutIfNeeded()
        goBackButton.backgroundColor = UIColor.white
        goBackButton.setTitle("Go Back", for: .normal)
        goBackButton.setTitleColor(UIColor.blue, for: .normal)
        goBackButton.layer.borderWidth = 2.0
        goBackButton.layer.cornerRadius = 3.0
        goBackButton.layer.borderColor = UIColor.blue.cgColor
        goBackButton.layer.masksToBounds = true
        goBackButton.addTarget(self, action: #selector(goBackButtonClicked), for: .touchUpInside)
        self.view.addSubview(goBackButton)
        
    }
    
    
    func signupButtonClicked() {
        //TODO: Implement this method with Firebase!
        //let profileImageData = UIImageJPEGRepresentation(profileImageView.image!, 0.9)
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let name = nameTextField.text!
        
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (User, error) in
            if error == nil {
                let ref = Database.database().reference().child("Users").child((Auth.auth().currentUser?.uid)!)
                //let storage = Storage.storage().reference().child("profilepics/\((Auth.auth().currentUser?.uid)!)")
                //let metadata = StorageMetadata()
                //metadata.contentType = "image/jpeg"
                //storage.putData(profileImageData!, metadata: metadata).observe(.success) { (snapshot) in
                    //let url = snapshot.metadata?.downloadURL()?.absoluteString
                    ref.setValue(["name": name, "email": email, /*"imageUrl": url*/])
                    //self.performSegue(withIdentifier: "toFeedFromSignup", sender: self)
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.nameTextField.text = ""
                    self.performSegue(withIdentifier: "toFeedFromSignup", sender: self)
                    
                //}
                
                
                
            }
            else {
                print(error.debugDescription)
            }
        })
    }
    
    func goBackButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        selectFromLibraryButton.removeFromSuperview()
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //profileImageView.contentMode = .scaleAspectFit
        //profileImageView.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
