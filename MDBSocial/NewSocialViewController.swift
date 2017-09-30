
//
//  ViewController.swift
//  MDBSocial
//
//  Created by Nikita Ashok on 9/27/17.
//  Copyright © 2017 Nikita Ashok. All rights reserved.
//

import UIKit
import Firebase

class NewSocialViewController: UIViewController {
    
    var newText: UITextField!
    var navBar: UINavigationBar!
    var eventName: UITextField!
    //var date: UIDatePicker = UIDatePicker()
    var picLibrary: UIButton!
    var imgPick = UIImagePickerController()
    var dateTime: UITextField!
    var picChosen: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newText = UITextField(frame: CGRect(x:0, y:0, width: view.frame.width, height: view.frame.height*0.5))
        newText.placeholder = "description.."
        newText.backgroundColor = UIColor.white
        view.addSubview(newText)
        
        eventName = UITextField(frame: CGRect(x: view.frame.width * 0.197, y: view.frame.height * 0.60, width: 227, height: 42))
        eventName.background = #imageLiteral(resourceName: "nameNumberField")
        eventName.borderStyle = .none
        eventName.placeholder = "event name.."
        eventName.textAlignment = .natural
        eventName.font = UIFont(name: "AppleSDGothicNeo", size: 14)
        view.addSubview(eventName)
        
        dateTime = UITextField(frame: CGRect(x: view.frame.width * 0.197, y: view.frame.height * 0.675, width: 227, height: 42))
        dateTime.background = #imageLiteral(resourceName: "nameNumberField")
        dateTime.borderStyle = .none
        dateTime.placeholder = "date/time.."
        dateTime.textAlignment = .natural
        dateTime.font = UIFont(name: "AppleSDGothicNeo", size: 14)
        view.addSubview(dateTime)
        
        
        /*date = UIDatePicker(frame: CGRect(x: view.frame.width * 0.197, y: view.frame.height * 0.75, width: 227, height: 42))
        date.layer.cornerRadius = 8
        date.backgroundColor = UIColor.white
        date.timeZone = NSTimeZone.local
        date.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        view.addSubview(date)*/
        
        picLibrary = UIButton(frame: CGRect(x: view.frame.width * 0.197, y: view.frame.height * 0.80, width: 227, height: 42))
        picLibrary.layer.cornerRadius = 8
        picLibrary.setTitle("Picture Library", for: .normal)
        picLibrary.backgroundColor = UIColor.white
        picLibrary.setTitleColor(UIColor.black, for: .normal)
        picLibrary.addTarget(self, action: #selector(choosePic), for: .touchUpInside)
        view.addSubview(picLibrary)
        
        
        picChosen = UIImageView(frame: CGRect(x: 0, y: view.frame.width * 0.60, width: view.frame.width * 0.25, height: view.frame.height*0.10))
        view.addSubview(picChosen)

        
        view.backgroundColor = UIColor(red: 151/255, green: 206/255, blue: 199/255, alpha: 1.0)
        setupNavBar()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func choosePic(sender: UIButton!) {
        imgPick.delegate = self
        imgPick.allowsEditing = false
        imgPick.sourceType = .photoLibrary
        imgPick.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imgPick, animated: true, completion: nil)
    }
    
    func setupNavBar() {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.08))
        let navItem = UINavigationItem(title: "New Event");
        let post = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(makePost))
        navItem.rightBarButtonItem = post
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    func makePost() {
        self.performSegue(withIdentifier: "newEventToFeed", sender: self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension NewSocialViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        picChosen.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
}


