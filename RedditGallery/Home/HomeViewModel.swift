//
//  HomeViewModel.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 19/11/20.
//

import Foundation

protocol HomeViewModelDelegate: NSObject {
    func reloadHomeData()
    func notifyNoData()
}

class HomeViewModel: NSObject, ImagesRepoDelegate {
    
    override init() {
        super.init()
        ImagesRepo.addImagesRepoObserver(observer: self)
    }
    
    weak var delegate: HomeViewModelDelegate?
    
    var images: [Images] = [Images]() {
        didSet {
            delegate?.reloadHomeData()
        }
    }
    
    func search(textToSearch: String) {
        ImagesRepo.textToSearch = textToSearch
    }
    
    internal func didChangedData() {
        images = ImagesRepo.images
    }
    
    internal func noData() {
        delegate?.notifyNoData()
    }
    
}
