//
//  ImageDetailRepo.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 18/11/20.
//

import Foundation

class ImageDetailRepo: NSObject {
    
    init(selectedIndex: Int) {
        super.init()
        self.selectedIndex = selectedIndex
    }
    
    var selectedIndex: Int = 0
}
