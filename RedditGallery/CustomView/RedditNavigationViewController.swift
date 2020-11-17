//
//  RedditNavigationViewController.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//

import UIKit

class RedditNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setLargeTitle()
    }
    
    func setLargeTitle() {
        DispatchQueue.main.async {
            self.navigationBar.prefersLargeTitles = true
            self.navigationBar.sizeToFit()
            self.navigationItem.largeTitleDisplayMode = .always
            self.view.setNeedsUpdateConstraints()
        }
    }
}
