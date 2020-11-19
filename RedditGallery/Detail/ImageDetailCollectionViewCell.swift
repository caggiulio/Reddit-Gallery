//
//  ImageDetailCollectionViewCell.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//

import UIKit

class ImageDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var favouriteButton: RedditFavouritesButton!
    @IBOutlet weak var authorLabel: RedditSubtitleLabel!
    @IBOutlet weak var titleLabel: RedditLabel!
    @IBOutlet weak var imageDetailView: RedditImageView!
    
    var image: Images?
    var index: Int = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageDetailView.clipsToBounds = true
        imageDetailView.layer.cornerRadius = 10
    }
    
    func fillCell(image: Images) {
        self.image = image
        var resIndex: Int = 0
        resIndex = max(0, image.resolutions?.count ?? 0)
        if let url = image.resolutions?[resIndex - 1].url {
            self.imageDetailView.sd_setImage(with: URL(string: url.convertSpecialCharacters()), placeholderImage: UIImage(named: "placeholder"))
            self.titleLabel.text = image.title
            self.authorLabel.text = image.author
            self.favouriteButton.setSelected(image.isPreferred)
        }
    }
    
    @IBAction func saveImageAction(_ sender: RedditFavouritesButton) {
        if let img = image, let imgId = img.id {
            if img.isPreferred {
                img.isPreferred = false
                CoreDataRepo.shared.deleteImage(id: imgId)
                ImagesRepo.replaceImage(img: img, index: index)
            } else {
                if let imgOnImageView = self.imageDetailView.image, let imgData = imgOnImageView.pngData() {
                    img.isPreferred = true
                    CoreDataRepo.shared.addFavouriteImage(id: imgId, imageData: imgData)
                    ImagesRepo.replaceImage(img: img, index: index)
                }
            }
        }
    }
}
