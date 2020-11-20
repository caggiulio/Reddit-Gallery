//
//  FavouriteDetailViewController.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 19/11/20.
//

import UIKit
import Hero

class FavouriteDetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: RedditImageView!
    var favouriteImageViewModel: FavouriteDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHero()
        
        if let data = favouriteImageViewModel?.image?.imageBinary {
            self.detailImageView.image = UIImage(data: data)
            self.detailImageView.enableZoom()
        }
    }
    
    func setupHero() {
        self.hero.isEnabled = true
        self.detailImageView.heroID = favouriteImageViewModel?.heroID
    }
}
