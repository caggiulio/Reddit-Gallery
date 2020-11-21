//
//  HomeCollectionViewCell.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//

import UIKit
import SDWebImage
import Hero

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var favouritesButton: RedditFavouritesButton!
    @IBOutlet weak var authorLabel: RedditSubtitleLabel!
    @IBOutlet weak var titleLabel: RedditLabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var homeImageViewCell: RedditImageView!
        
    private var homeCellViewModel: HomeCollectionViewModelCell?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.homeImageViewCell.clipsToBounds = true
        self.homeImageViewCell.layer.cornerRadius = 8
        self.homeImageViewCell.addGradientTransparentAtBottom()
    }
    
    func setup(vm: HomeCollectionViewModelCell) {
        self.hero.isEnabled = true
        self.homeCellViewModel = vm
        fillCell()
    }
    
    private func fillCell() {
        self.heroID = "collection\(String(describing: homeCellViewModel?.index))"
        var resIndex: Int = 0
        resIndex = max(0, homeCellViewModel?.image?.resolutions?.count ?? 0)
        if let url = homeCellViewModel?.image?.resolutions?[resIndex - 1].url {
            self.homeImageViewCell.sd_setImage(with: URL(string: url.convertSpecialCharacters()), placeholderImage: UIImage(named: "placeholder"))
            self.titleLabel.text = homeCellViewModel?.image?.title
            self.authorLabel.text = homeCellViewModel?.image?.author
            self.favouritesButton.setSelected(homeCellViewModel?.image?.isPreferred ?? false)
        }
    }
    
    @IBAction func saveImageAction(_ sender: RedditFavouritesButton) {
        if let img = homeCellViewModel?.image {
            if img.isPreferred {
                img.isPreferred = false
                self.animateCellWithBounce(mode: .notPreferred) {
                    self.homeCellViewModel?.updateRepo(img: img, method: .remove)
                }
            } else {
                if let imgOnImageView = self.homeImageViewCell.image, let imgData = imgOnImageView.pngData() {
                    img.isPreferred = true
                    self.animateCellWithBounce(mode: .preferred) {
                        self.homeCellViewModel?.updateRepo(img: img, method: .add, data: imgData)
                    }
                }
            }
        }
    }
}
