//
//  ImageDetailViewController.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    var images: [Images] = [Images]()
    var selectedIndex: Int = 0
    var isAlreadyPresented: Bool = false
    
    var imageDetailRepo: ImageDetailRepo?

    @IBOutlet weak var imagesDetailCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesDetailCollectionView.delegate = self
        imagesDetailCollectionView.dataSource = self
        
        imagesDetailCollectionView.collectionViewLayout = RedditCollectionFlowLayout()
        imagesDetailCollectionView.isPagingEnabled = false
        imagesDetailCollectionView.decelerationRate = .fast
        
        ImagesRepo.addImagesRepoObserver(observer: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isAlreadyPresented == false {
            isAlreadyPresented = true
            scrollToSelectedIndex()
        }
    }
    
    func scrollToSelectedIndex() {
        self.imagesDetailCollectionView.scrollToItem(at: IndexPath(item: imageDetailRepo?.selectedIndex ?? 0, section: 0), at: .left, animated: false)
    }
}

extension ImageDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImagesRepo.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageDetailViewController", for: indexPath) as! ImageDetailCollectionViewCell
        let img = ImagesRepo.images[indexPath.item]
        cell.fillCell(image: img)
        cell.index = indexPath.item
        
        return cell
    }
}

extension ImageDetailViewController: ImagesRepoDelegate {
    func reloadData() {
        imagesDetailCollectionView.reloadData()
    }
}
