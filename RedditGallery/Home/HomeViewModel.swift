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
    
    var searchTask: DispatchWorkItem?
    
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
        self.searchTask?.cancel()
        let task = DispatchWorkItem { [weak self] in
            ImagesRepo.textToSearch = textToSearch
        }
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: task)
    }
    
    internal func didChangedData() {
        images = ImagesRepo.images
    }
    
    internal func noData() {
        delegate?.notifyNoData()
    }
    
}
