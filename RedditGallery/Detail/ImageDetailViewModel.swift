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
    
    internal func fetchImages() {
        self.images = ImagesRepo.images
    }
    
    init(selectedIndex: Int) {
        super.init()
        self.selectedIndex = selectedIndex
        ImagesRepo.addImagesRepoObserver(observer: self)
        fetchImages()
    }
    
    var selectedIndex: Int = 0
    
    func didChangedData() {
        self.images = ImagesRepo.images
    }
}
