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
    
    private var homeCellViewModel: ImageDetailsViewModelCell?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageDetailView.clipsToBounds = true
        imageDetailView.layer.cornerRadius = 10
    }
    
    func setup(vm: ImageDetailsViewModelCell) {
        self.homeCellViewModel = vm
        fillCell()
    }
    
    private func fillCell() {
        var resIndex: Int = 0
        resIndex = max(0, homeCellViewModel?.image?.resolutions?.count ?? 0)
        if let url = homeCellViewModel?.image?.resolutions?[resIndex - 1].url {
            self.imageDetailView.sd_setImage(with: URL(string: url.convertSpecialCharacters()), placeholderImage: UIImage(named: "placeholder"))
            self.titleLabel.text = homeCellViewModel?.image?.title
            self.authorLabel.text = homeCellViewModel?.image?.author
            self.favouriteButton.setSelected(homeCellViewModel?.image?.isPreferred ?? false)
        }
    }
    
    @IBAction func saveImageAction(_ sender: RedditFavouritesButton) {
        if let img = homeCellViewModel?.image, let imgId = img.id {
            if img.isPreferred {
                img.isPreferred = false
                CoreDataRepo.shared.deleteImage(id: imgId)
                homeCellViewModel?.updateRepo(img: img)
            } else {
                if let imgOnImageView = self.imageDetailView.image, let imgData = imgOnImageView.pngData() {
                    img.isPreferred = true
                    CoreDataRepo.shared.addFavouriteImage(id: imgId, imageData: imgData)
                    homeCellViewModel?.updateRepo(img: img)
                }
            }
        }
    }
}
