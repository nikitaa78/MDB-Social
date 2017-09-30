//
//  User.swift
//  MDBSocial
//
//  Created by Nikita Ashok on 9/27/17.
//  Copyright © 2017 Nikita Ashok. All rights reserved.
//

import Foundation
import UIKit

class User {
    var name: String?
    var email: String?
    var imageUrl: String?
    var id: String?
    
    init(id: String, userDict: [String:Any]?) {
        self.id = id
        if userDict != nil {
            if let name = userDict!["name"] as? String {
                self.name = name
            }
            if let imageUrl = userDict!["imageUrl"] as? String {
                self.imageUrl = imageUrl
            }
            if let email = userDict!["email"] as? String {
                self.email = email
            }
            
        }
    }
    
    
}
