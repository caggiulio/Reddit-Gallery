//
//  FavouriteDetailViewModel.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 19/11/20.
//

import Foundation

class FavouriteDetailViewModel: NSObject {
    
    var image: FavouritesImages?
    var heroID: String? = nil
    
    init(image: FavouritesImages, heroID: String? = nil) {
        self.image = image
        self.heroID = heroID
    }
    
}

