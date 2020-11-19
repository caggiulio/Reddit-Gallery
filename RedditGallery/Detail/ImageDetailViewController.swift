//
//  ImageDetailViewController.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    var images: [Images] = [Images]()
    var isAlreadyPresented: Bool = false
    
    var imageDetailViewModel: ImageDetailViewModel?

    @IBOutlet weak var imagesDetailCollectionView: UICollectionView!
    
    func setup(vm: ImageDetailViewModel) {
        self.imageDetailViewModel = vm
        self.imageDetailViewModel?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        imagesDetailCollectionView.delegate = self
        imagesDetailCollectionView.dataSource = self
        
        imagesDetailCollectionView.collectionViewLayout = RedditCollectionFlowLayout()
        imagesDetailCollectionView.isPagingEnabled = false
        imagesDetailCollectionView.decelerationRate = .fast
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isAlreadyPresented == false {
            isAlreadyPresented = true
            scrollToSelectedIndex()
        }
    }
    
    func scrollToSelectedIndex() {
        self.imagesDetailCollectionView.scrollToItem(at: IndexPath(item: imageDetailViewModel?.selectedIndex ?? 0, section: 0), at: .left, animated: false)
    }
}

extension ImageDetailViewController: ImageDetailViewModelDelegate {
    func reloadImageDetailsView() {
        imagesDetailCollectionView.reloadData()
    }
}

extension ImageDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDetailViewModel?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageDetailViewController", for: indexPath) as! ImageDetailCollectionViewCell
        if let img = imageDetailViewModel?.images[indexPath.item] {
            cell.setup(vm: ImageDetailsViewModelCell(image: img, index: indexPath.item))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}
