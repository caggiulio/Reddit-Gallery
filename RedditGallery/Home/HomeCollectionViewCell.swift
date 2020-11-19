//
//  HomeCollectionViewCell.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//

import UIKit
import SDWebImage

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var favouritesButton: RedditFavouritesButton!
    @IBOutlet weak var authorLabel: RedditSubtitleLabel!
    @IBOutlet weak var titleLabel: RedditLabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var homeImageViewCell: RedditImageView!
        
    var image: Images?
    var index: Int = 0
    
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
            self.favouritesButton.setSelected(image.isPreferred)
        }
    }
    
    @IBAction func saveImageAction(_ sender: RedditFavouritesButton) {
        if let img = image, let imgId = img.id {
            if img.isPreferred {
                img.isPreferred = false
                CoreDataRepo.shared.deleteImage(id: imgId)
                self.animateCell {
                    ImagesRepo.replaceImage(img: img, index: self.index)
                }
            } else {
                if let imgOnImageView = self.homeImageViewCell.image, let imgData = imgOnImageView.pngData() {
                    img.isPreferred = true
                    CoreDataRepo.shared.addFavouriteImage(id: imgId, imageData: imgData)
                    self.animateCell {
                        ImagesRepo.replaceImage(img: img, index: self.index)
                    }
                }
            }
        }
    }
    
    
    func animateCell(completion: @escaping () -> ()) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4, animations: {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }) { (_) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                }) { (_) in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.transform = CGAffineTransform.identity
                    }) { (_) in
                        completion()
                    }
                }
            }
        }
    }
}
