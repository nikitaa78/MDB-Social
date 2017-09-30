//
//  Post.swift
//  MDBSocial
//
//  Created by Nikita Ashok on 9/27/17.
//  Copyright © 2017 Nikita Ashok. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class Post {
    var text: String?
    var imageUrl: String?
    var posterId: String?
    var poster: String?
    var id: String?
    var image: UIImage?
    
    
    init(id: String, postDict: [String:Any]?) {
        self.id = id
        if postDict != nil {
            if let text = postDict!["text"] as? String {
                self.text = text
            }
            if let imageUrl = postDict!["imageUrl"] as? String {
                self.imageUrl = imageUrl
            }
            if let posterId = postDict!["posterId"] as? String {
                self.posterId = posterId
            }
            if let poster = postDict!["poster"] as? String {
                self.poster = poster
            }
        }
    }
    
    init() {
        self.text = "Hi please work"
        self.imageUrl = "https://cmgajcmusic.files.wordpress.com/2016/06/kanye-west2.jpg"
        self.id = "1"
        self.poster = "Kanye West"
    }
    
    func getProfilePic(withBlock: @escaping () -> ()) {
        //TODO: Get User's profile picture
        let ref = Storage.storage().reference().child("/postPics/\(id!)")
        //ref = Storage.storage().reference().child("/profilepics/\(posterId!)")
        ref.getData(maxSize: 1 * 2048 * 2048)  { data, error in
            if let error = error {
                print(error)
            } else {
                self.image = UIImage(data: data!)
                withBlock()
            }
        }
    }
}
