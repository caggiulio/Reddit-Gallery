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
    
    func reloadData() {
        self.homeCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeRepo?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        if let img = homeRepo?.images[indexPath.item] {
            cell.fillCell(image: img)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "imageDetailViewController") as! ImageDetailViewController
        if let images = homeRepo?.images {
            let imageDetailRepo = ImageDetailRepo(images: images, selectedIndex: indexPath.item)
            vc.imageDetailRepo = imageDetailRepo
        }
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        homeRepo?.textToSearch = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
