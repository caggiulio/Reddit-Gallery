//
//  ImagesRepo.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//

import Foundation
import Falcon
import Alamofire

protocol ImagesRepoDelegate: AnyObject {
    func didChangedData()
    func noData()
}

class ImagesRepo: NSObject {
    
    override init() { }
    
    static var observers = [ImagesRepoDelegate]()
    
    static var images: [Images] = [Images]() {
        didSet {
            notifyObservers()
        }
    }
    
    static func addImagesRepoObserver(observer: ImagesRepoDelegate) {
        observers.append(observer)
    }
    
    static func notifyObservers() {
        DispatchQueue.main.async {
            for o in observers {
                o.didChangedData()
            }
        }
    }
    
    static func notifyObserverNoData() {
        DispatchQueue.main.async {
            for o in observers {
                o.noData()
            }
        }
    }
    
    static var textToSearch: String = "" {
        didSet {
            search(searchToText: textToSearch)
        }
    }
    
    static func search(searchToText: String) {
        if !searchToText.isEmpty {
            //Falcon.cancelAllRequest()
            self.fetchImages(searchString: searchToText)
        } else {
            self.images.removeAll()
        }
    }
    
    static func fetchImages(searchString: String) {
        self.images.removeAll()
        Falcon.request(url: "/r/\(searchString)/top.json", method: .get) { (result) in
            switch result {
            
            case let .success(response):
                if let data = response.data {
                    if response.success {
                        let redditResult = try? JSONDecoder().decode(RedditResult.self, from: data)
                        if let data = redditResult?.data, let childrens = data.childrens {
                            print(childrens.count)
                            var imgsToPass: [Images] = [Images]()
                            for child in childrens {
                                if let previews = child.preview {
                                    if let img = previews.images?.first {
                                        img.title = child.title
                                        img.author = child.authorFullname
                                        imgsToPass.append(img)
                                    }
                                }
                            }
                            if imgsToPass.count == 0 {
                                notifyObserverNoData()
                                return
                            } else {
                                self.images = imgsToPass
                            }
                        } else {
                            notifyObserverNoData()
                        }
                    }
                }
                
            case let .error(response, error): break
                
            }
        }
    }
    
    static func replaceImage(img: Images, index: Int) {
        ImagesRepo.images[index] = img
    }
    
    static func addImage(img: Images) {
        ImagesRepo.images.append(img)
    }
    
    static func removeImage(img: Images) {
        ImagesRepo.images.removeEqualItems(img)
    }
    
    static func cancelRequest() {
        AF.session.getAllTasks { (tasks) in
            tasks.forEach { $0.cancel() }
        }
    }
}

extension ImagesRepoDelegate {
    func noData() {

    }
}

