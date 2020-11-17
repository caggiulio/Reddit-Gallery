//
//  HomeViewController.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    var homeRepo: HomeRepo?
    var images: [Images] = [Images]() {
        didSet {
            homeCollectionView.reloadData()
        }
    }
    
    var searchToText: String = "" {
        didSet {
            search(searchToText: searchToText)
        }
    }
    
    func search(searchToText: String) {
        if !searchToText.isEmpty {
            homeRepo?.cancelRequest()
            homeRepo?.fetchImages(searchString: searchToText)
        } else {
            self.images.removeAll()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        
        homeRepo = HomeRepo()
        homeRepo?.delegate = self
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        setSearchController()
    }
    
    func setSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
    }
}

extension HomeViewController: HomeRepoDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UISearchControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        let img = images[indexPath.item]
        cell.fillCell(image: img)
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func passImages(images: [Images]) {
        self.images = images
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchToText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
}
