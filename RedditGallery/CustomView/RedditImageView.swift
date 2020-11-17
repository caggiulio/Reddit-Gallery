//
//  RedditImageView.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//

import UIKit

class RedditImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.clipsToBounds = true
    }
}

