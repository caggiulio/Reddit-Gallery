//
//  HomeRepo.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//

import Foundation
import HTTPiOSCLient

protocol HomeRepoDelegate: AnyObject {
    func passImages(images: [Images])
}

class HomeRepo: NSObject {
    
    override init() {}
    weak var delegate: HomeRepoDelegate?
    
    
    func fetchImages(searchString: String) {
        Falcon.request(url: "/r/\(searchString)/top.json", method: .get) { (result) in
            switch result {
            
            case let .success(response):
                if let data = response.data {
                    if response.success {
                        let redditResult = try? JSONDecoder().decode(RedditResult.self, from: data)
                        print(redditResult)
                    }
                }
                
            case let .error(response, error): break
                
            }
        }
    }
}

