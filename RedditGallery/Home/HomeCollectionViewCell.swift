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
        
    private var homeCellViewModel: HomeCollectionViewModelCell?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.homeImageViewCell.clipsToBounds = true
        self.homeImageViewCell.layer.cornerRadius = 8
        self.homeImageViewCell.addGradientTransparentAtBottom()
    }
    
    func setup(vm: HomeCollectionViewModelCell) {
        self.homeCellViewModel = vm
        fillCell()
    }
    
    private func fillCell() {
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
        if let img = homeCellViewModel?.image, let imgId = img.id, let index = homeCellViewModel?.index {
            if img.isPreferred {
                img.isPreferred = false
                CoreDataRepo.shared.deleteImage(id: imgId)
                self.animateCell {
                    self.homeCellViewModel?.updateRepo(img: img)
                }
            } else {
                if let imgOnImageView = self.homeImageViewCell.image, let imgData = imgOnImageView.pngData() {
                    img.isPreferred = true
                    CoreDataRepo.shared.addFavouriteImage(id: imgId, imageData: imgData)
                    self.animateCell {
                        self.homeCellViewModel?.updateRepo(img: img)
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
