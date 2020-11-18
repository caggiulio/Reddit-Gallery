//
//  HomeCollectionViewCell.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//

import UIKit
import SDWebImage
class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var authorLabel: RedditSubtitleLabel!
    @IBOutlet weak var titleLabel: RedditLabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var homeImageViewCell: RedditImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.homeImageViewCell.clipsToBounds = true
        self.homeImageViewCell.layer.cornerRadius = 8
        self.homeImageViewCell.addGradientTransparentAtBottom()
    }
    
    func fillCell(image: Images) {
        var resIndex: Int = 0
        resIndex = max(0, image.resolutions?.count ?? 0)
        if let url = image.resolutions?[resIndex - 1].url {
            self.homeImageViewCell.sd_setImage(with: URL(string: url.convertSpecialCharacters()), placeholderImage: UIImage(named: "placeholder"))
            self.titleLabel.text = image.title
            self.authorLabel.text = image.author
        }
    }
}
