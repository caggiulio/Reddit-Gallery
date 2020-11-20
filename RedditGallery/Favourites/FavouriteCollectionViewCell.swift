//
//  FavouriteCollectionViewCell.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 19/11/20.
//

import UIKit
import  Hero

class FavouriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var favouriteRemoveButton: RedditFavouritesButton!
    @IBOutlet weak var favouriteImageView: RedditImageView!
    
    var favouriteCollectionCellViewModel: FavouritesImageCellViewModel?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.favouriteImageView.clipsToBounds = true
        self.favouriteImageView.layer.cornerRadius = 8
        favouriteRemoveButton.setSelected(true)
    }
    
    func setup(vm: FavouritesImageCellViewModel) {
        hero.isEnabled = true
        favouriteCollectionCellViewModel = vm
        fillCell()
    }
    
    func fillCell() {
        if let data = favouriteCollectionCellViewModel?.image?.imageBinary {
            self.favouriteImageView.image = UIImage(data: data)
            if let index = favouriteCollectionCellViewModel?.index {
                self.heroID = "favouriteImage\(index)"
            }
        }
    }

    @IBAction func removeFavourite(_ sender: RedditFavouritesButton) {
        favouriteCollectionCellViewModel?.removeFavouriteImage()
    }
}
