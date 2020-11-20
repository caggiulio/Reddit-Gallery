//
//  ImageDetailRepo.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 18/11/20.
//

import Foundation

protocol ImageDetailViewModelDelegate: NSObject {
    func reloadImageDetailsView()
}

class ImageDetailViewModel: NSObject, ImagesRepoDelegate {
    
    weak var delegate: ImageDetailViewModelDelegate?
    
    var images: [Images] = [Images]() {
        didSet {
            delegate?.reloadImageDetailsView()
        }
    }
    
    init(selectedIndex: Int, images: [Images]) {
        super.init()
        self.selectedIndex = selectedIndex
        ImagesRepo.addImagesRepoObserver(observer: self)
        self.images = images
    }
    
    var selectedIndex: Int = 0
    
    func didChangedData() {
        self.images = ImagesRepo.images
    }
}
