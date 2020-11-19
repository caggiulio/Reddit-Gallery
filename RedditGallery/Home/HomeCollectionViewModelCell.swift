//
//  HomeCollectionViewModelCell.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 19/11/20.
//

import Foundation

class HomeCollectionViewModelCell: NSObject {
    
    var image: Images?
    var index: Int = 0
    
    init(image: Images, index: Int) {
        super.init()
        self.image = image
        self.index = index
    }
    
    func updateRepo(img: Images) {
        ImagesRepo.replaceImage(img: img, index: index)
    }

}
