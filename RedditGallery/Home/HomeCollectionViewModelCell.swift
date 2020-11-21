//
//  HomeCollectionViewModelCell.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 19/11/20.
//

import Foundation

enum FavouriteMethod {
    case add
    case remove
}

class HomeCollectionViewModelCell: NSObject {
    var image: Images?
    var index: Int = 0
    
    init(image: Images, index: Int) {
        super.init()
        self.image = image
        self.index = index
    }
    
    func updateRepo(img: Images, method: FavouriteMethod, data: Data? = nil) {
        if let id = img.id {
            if method == .remove {
                CoreDataRepo.deleteImage(id: id)
            } else {
                if let data = data {
                    CoreDataRepo.addFavouriteImage(id: id, imageData: data)
                }
            }
        }
        ImagesRepo.replaceImage(img: img, index: index)
    }
}
