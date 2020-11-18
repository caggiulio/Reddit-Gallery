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
    var scrollView: UIScrollView?
    var cellWidth: CGFloat = 300
    var cellHeight: CGFloat = 500

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
        searchController.searchBar.searchTextField.font = FontBook.Medium.of(size: 12)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
    }
}

extension HomeViewController: HomeRepoDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UISearchControllerDelegate {
    
    func reloadData() {
        self.homeCollectionView.reloadData()
        self.homeCollectionView.layoutIfNeeded()
        setBackgroundScrollImages()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeRepo?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        if let img = homeRepo?.images[indexPath.item] {
            cell.fillCell(image: img)
            cell.homeRepo = homeRepo
            cell.index = indexPath.item
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
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension HomeViewController {
    func setBackgroundScrollImages() {
        DispatchQueue.main.async {
            if let imgs = self.homeRepo?.images {
                if imgs.count > 0 {
                    self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height * CGFloat(self.homeRepo?.images.count ?? 0)))
                    self.scrollView?.showsVerticalScrollIndicator = false
                    self.scrollView!.delegate = self
                    for index in 0...(imgs.count - 1) {
                        self.scrollView!.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height * CGFloat(imgs.count))
                        
                        let imageView = UIImageView(frame: CGRect(x: 0, y: ((self.view.bounds.height * 0.9) * CGFloat(index)), width: self.view.bounds.width, height: self.view.bounds.height)).addBlur()
                        imageView.addGradientTransparent()
                        
                        imageView.contentMode = .scaleAspectFill
                        if index < (imgs.count) {
                            let img = imgs[index]
                            
                            imageView.sd_setImage(with: URL(string: (img.resolutions![0].url?.convertSpecialCharacters())!))
                            self.scrollView!.addSubview(imageView)
                            self.homeCollectionView.backgroundView = self.scrollView
                        }
                    }
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setParallaxBackground()
    }
    
    func setParallaxBackground() {
        if let scrollViewBackground = self.scrollView {
            var point = self.homeCollectionView.contentOffset
            
            let currentTableViewCellHeight: CGFloat = cellHeight
                
                point.y -= 150
                point.y *= ((self.view.bounds.height * 0.9) / (currentTableViewCellHeight))
                if point.y < 0 {
                    point.y = 0
                }
                scrollViewBackground.setContentOffset(point, animated: false)
            
        }
    }
}
