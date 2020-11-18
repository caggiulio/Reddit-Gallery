//
//  ImageDetailRepo.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 18/11/20.
//

import Foundation

protocol ImageDetailRepoDelegate: AnyObject {
    func reloadData()
}

class ImageDetailRepo: NSObject {
    
    init(images: [Images], selectedIndex: Int) {
        super.init()
        self.images = images
        self.selectedIndex = selectedIndex
    }
    
    weak var delegate: ImageDetailRepoDelegate?
    
    var images: [Images] = [Images]() {
        didSet {
            delegate?.reloadData()
        }
    }
    
    var selectedIndex: Int = 0
}
