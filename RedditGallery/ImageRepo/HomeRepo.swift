//
//  ImagesRepo.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//

import Foundation
import HTTPiOSCLient
import Alamofire

protocol ImagesRepoDelegate: AnyObject {
    func reloadData()
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
                o.reloadData()
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
            self.cancelRequest()
            self.fetchImages(searchString: searchToText)
        } else {
            self.images.removeAll()
        }
    }
    
    static func fetchImages(searchString: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
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
                                self.images = imgsToPass
                            }
                        }
                    }
                    
                case let .error(response, error): break
                    
                }
            }
        }
    }
    
    static func replaceImage(img: Images, index: Int) {
        ImagesRepo.images[index] = img
    }
    
    static func cancelRequest() {
        AF.session.getAllTasks { (tasks) in
            tasks.forEach { $0.cancel() }
        }
    }
}

