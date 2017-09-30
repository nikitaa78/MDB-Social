//
//  PostCollectionViewCell.swift
//  MDBSocial
//
//  Created by Nikita Ashok on 9/27/17.
//  Copyright © 2017 Nikita Ashok. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    var image: UIImageView!
    var name: UILabel!
    var text: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
        setupImage()
        setupName()
        setupText()
    }
    
    func setupImage() {
        image = UIImageView(frame: CGRect(x: 10, y: 10, width: 0.50 * self.frame.height, height: 0.50 * self.frame.height))
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        addSubview(image)
    }
    
    func setupName() {
        name = UILabel(frame: CGRect(x: image.frame.maxX + 10, y: 10, width: self.frame.width, height: 30))
        name.textColor = UIColor.black
        name.font = UIFont.systemFont(ofSize: 24, weight: 2)
        name.adjustsFontForContentSizeCategory = true
        addSubview(name)
    }
    
    func setupText() {
        text = UILabel(frame: CGRect(x: image.frame.maxX + 10, y: name.frame.maxY + 10, width: self.frame.width, height: 0.5 * self.frame.height - 40))
        text.textColor = UIColor.black
        text.adjustsFontForContentSizeCategory = true
        addSubview(text)
    }
    
}

