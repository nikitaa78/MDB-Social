//
//  DetailViewController.swift
//  MDBSocial
//
//  Created by Nikita Ashok on 9/29/17.
//  Copyright © 2017 Nikita Ashok. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var post: Post!
    var back: UIButton!
    var img: UIImageView!
    var person: UILabel!
    var eventText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        back = UIButton(frame: CGRect(x: view.frame.width*0.04, y: 10, width: 27, height: 30))
        back.setTitle("X", for: .normal)
        back.backgroundColor = UIColor.blue
        back.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(back)
        
        let img = UIImageView(frame: CGRect(x: 0, y: view.frame.width*0, width: view.frame.width, height: view.frame.width))
        img.contentMode = .scaleAspectFit
        if let url = post.imageUrl {
            do {
                try img.image = UIImage(data:Data(contentsOf: URL(string: url)!))
            } catch {
                img.image = #imageLiteral(resourceName: "fun")
            }
        } else {
            NSLog("No image url found")
        }
        view.addSubview(img)
        
        person = UILabel(frame: CGRect(x: view.frame.width*0.20, y: view.frame.height*0.6, width: 227, height: 42))
        person.textAlignment = .center
        person.layer.cornerRadius = 8
        person.layer.masksToBounds = true
        person.backgroundColor = UIColor(red: 151/255, green: 206/255, blue: 199/255, alpha: 1.0)
        person.adjustsFontSizeToFitWidth = true
        if let poster = self.post.poster {
            person.text = "Name: \(poster)"
        } else {
            person.text = "Poster"
        }
        view.addSubview(person)
        
       eventText = UILabel(frame: CGRect(x: view.frame.width*0.20, y: view.frame.height*0.70, width: 227, height: 42))
        eventText.backgroundColor = UIColor(red: 151/255, green: 206/255, blue: 199/255, alpha: 1.0)
        eventText.layer.cornerRadius = 8
        eventText.layer.masksToBounds = true
        eventText.textAlignment = .center
        eventText.adjustsFontSizeToFitWidth = true
        if let event = self.post.text {
            eventText.text = "Event Description: \(event)"
        } else {
            eventText.text = "Event Description"
        }
        view.addSubview(eventText)
        


        // Do any additional setup after loading the view.
    }
    
    func goBack() {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
