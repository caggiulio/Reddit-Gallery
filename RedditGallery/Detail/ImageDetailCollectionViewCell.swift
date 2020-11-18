//
//  ImageDetailCollectionViewCell.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//

import UIKit

class ImageDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageDetailView: RedditImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageDetailView.clipsToBounds = true
        imageDetailView.layer.cornerRadius = 10
    }
    
    func fillCell(image: Images) {
        var resIndex: Int = 0
        resIndex = max(0, image.resolutions?.count ?? 0)
        if let url = image.resolutions?[resIndex - 1].url {
            self.imageDetailView.sd_setImage(with: URL(string: url.convertSpecialCharacters()), placeholderImage: UIImage(named: "placeholder"))
        }
    }
}
