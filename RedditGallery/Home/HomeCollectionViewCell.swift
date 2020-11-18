//
//  HomeCollectionViewCell.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//

import UIKit
import SDWebImage
class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var homeImageViewCell: RedditImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.homeImageViewCell.clipsToBounds = true
        self.homeImageViewCell.layer.cornerRadius = 8
    }
    
    func fillCell(image: Images) {
        var resIndex: Int = 0
        if image.resolutions?.count ?? 0 > 3 {
            resIndex = 2
        } else if image.resolutions?.count ?? 0 > 2 {
            resIndex = 1
        }
        if let url = image.resolutions?[resIndex].url {
            self.homeImageViewCell.sd_setImage(with: URL(string: url.convertSpecialCharacters()), placeholderImage: UIImage(named: "placeholder"))
        }
    }
}
