//
//  FavouritesViewController.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 19/11/20.
//

import UIKit

class FavouritesViewController: UIViewController {

    @IBOutlet weak var favouritesCollectionView: UICollectionView!
    var favouritesViewModel: FavouriteViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favourites"

        favouritesCollectionView.delegate = self
        favouritesCollectionView.dataSource = self
        favouritesViewModel = FavouriteViewModel()
        favouritesViewModel?.delegate = self
    }
}

extension FavouritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouritesViewModel?.favouriteImages.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favouriteCollectionViewCell", for: indexPath) as! FavouriteCollectionViewCell
        if let img = favouritesViewModel?.favouriteImages[indexPath.item] {
            cell.setup(vm: FavouritesImageCellViewModel(image: img, index: indexPath.item))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let img = favouritesViewModel?.favouriteImages[indexPath.item] {
            
        }
    }
}

extension FavouritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 4.0
        let height = width
        return CGSize(width: width, height: height)
    }
}

extension FavouritesViewController: FavouriteViewModelDelegate {
    func reloadFavourites() {
        self.favouritesCollectionView.reloadData()
    }
}
