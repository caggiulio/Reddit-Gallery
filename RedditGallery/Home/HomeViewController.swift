//
//  HomeViewController.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//

import UIKit

class HomeViewController: UIViewController {
    
    var homeRepo: HomeRepo?

    override func viewDidLoad() {
        super.viewDidLoad()
        homeRepo = HomeRepo()
        homeRepo?.delegate = self
        homeRepo?.fetchImages(searchString: "spiderman")
    }
}

extension HomeViewController: HomeRepoDelegate {
    func passImages(images: [Images]) {
        
    }
}
