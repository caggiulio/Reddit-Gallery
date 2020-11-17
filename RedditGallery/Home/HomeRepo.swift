//
//  HomeRepo.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//

import Foundation
import HTTPiOSCLient
import Alamofire

protocol HomeRepoDelegate: AnyObject {
    func passImages(images: [Images])
}

class HomeRepo: NSObject {
    
    override init() {}
    weak var delegate: HomeRepoDelegate?
    
    func fetchImages(searchString: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            Falcon.request(url: "/r/\(searchString)/top.json", method: .get) { (result) in
                switch result {
                
                case let .success(response):
                    if let data = response.data {
                        if response.success {
                            let redditResult = try? JSONDecoder().decode(RedditResult.self, from: data)
                            if let data = redditResult?.data, let childrens = data.childrens {
                                print(childrens.count)
                                for child in childrens {
                                    if let previews = child.preview {
                                        if let imgs = previews.images {
                                            for img in imgs {
                                                if let res = img.resolutions {
                                                    
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                case let .error(response, error): break
                    
                }
            }
        }
    }
    
    func cancelRequest() {
        AF.session.getAllTasks { (tasks) in
            tasks.forEach { $0.cancel() }
        }
    }
}

