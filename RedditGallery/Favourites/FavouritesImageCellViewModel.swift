//
//  FavouritesImageCellViewModel.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 19/11/20.
//

import Foundation

class FavouritesImageCellViewModel: NSObject {
    
    var image: FavouritesImages?
    var index: Int = 0
    
    init(image: FavouritesImages, index: Int) {
        super.init()
        self.image = image
        self.index = index
    }
    
    func removeFavouriteImage() {
        if let id = image?.id {
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
}
