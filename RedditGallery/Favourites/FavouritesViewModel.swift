//
//  FavouritesViewModel.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 19/11/20.
//

import Foundation

protocol FavouriteViewModelDelegate: NSObject {
    func reloadFavourites()
}

class FavouriteViewModel: NSObject, CoreDataRepoDelegate {
    
    weak var delegate: FavouriteViewModelDelegate?
    
    var favouriteImages: [FavouritesImages] = [FavouritesImages]() {
        didSet {
            delegate?.reloadFavourites()
        }
    }
    
    override init() {
        super.init()
        CoreDataRepo.addCoreDataRepoObserver(observer: self)
        fetchImages()
    }
    
    func removeFavouriteImage(img: FavouritesImages) {
        if let id = img.id {
            CoreDataRepo.deleteImage(id: id)
            for (index, img) in ImagesRepo.images.enumerated() {
                if img.id == id {
                    img.isPreferred = false
                    ImagesRepo.images[index] = img
                    break
                }
            }
        }
    }
    
    func fetchImages() {
        self.favouriteImages = CoreDataRepo.loadAllImages()
    }
    
    func didCoreDataChanged() {
        self.favouriteImages = CoreDataRepo.loadAllImages()
    }
}
