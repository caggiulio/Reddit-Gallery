//
//  HomeCollectionViewCell.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//

import UIKit
import SDWebImage

protocol HomeCollectionViewCellDelegate: AnyObject {
    func deleteFavouriteImage()
    func saveFavouriteImage()
}

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var favouritesButton: RedditFavouritesButton!
    @IBOutlet weak var authorLabel: RedditSubtitleLabel!
    @IBOutlet weak var titleLabel: RedditLabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var homeImageViewCell: RedditImageView!
        
    var image: Images?
    var homeRepo: HomeRepo?
    var index: Int = 0
    
    weak var delegate: HomeCollectionViewCellDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.homeImageViewCell.clipsToBounds = true
        self.homeImageViewCell.layer.cornerRadius = 8
        self.homeImageViewCell.addGradientTransparentAtBottom()
    }
    
    func fillCell(image: Images) {
        self.image = image
        var resIndex: Int = 0
        resIndex = max(0, image.resolutions?.count ?? 0)
        if let url = image.resolutions?[resIndex - 1].url {
            self.homeImageViewCell.sd_setImage(with: URL(string: url.convertSpecialCharacters()), placeholderImage: UIImage(named: "placeholder"))
            self.titleLabel.text = image.title
            self.authorLabel.text = image.author
            DispatchQueue.main.async {
                self.favouritesButton.setSelected(image.isPreferred)
            }
        }
    }
    
    @IBAction func saveImageAction(_ sender: RedditFavouritesButton) {
        if let img = image, let imgId = img.id {
            if img.isPreferred {
                img.isPreferred = false
                CoreDataRepo.shared.deleteImage(id: imgId)
                homeRepo?.images[index] = img
            } else {
                if let imgOnImageView = self.homeImageViewCell.image, let imgData = imgOnImageView.pngData() {
                    img.isPreferred = true
                    CoreDataRepo.shared.addFavouriteImage(id: imgId, imageData: imgData)
                    homeRepo?.images[index] = img
                }
            }
        }
    }
}
