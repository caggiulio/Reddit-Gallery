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

    @IBOutlet weak var imagesDetailCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesDetailCollectionView.delegate = self
        imagesDetailCollectionView.dataSource = self
        
        imagesDetailCollectionView.collectionViewLayout = RedditCollectionFlowLayout()
        imagesDetailCollectionView.isPagingEnabled = false
        imagesDetailCollectionView.decelerationRate = .fast //-> this for scrollView speed
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isAlreadyPresented == false {
            isAlreadyPresented = true
            scrollToSelectedIndex()
        }
    }
    
    func scrollToSelectedIndex() {
        self.imagesDetailCollectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: false)
    }
}

extension ImageDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageDetailViewController", for: indexPath) as! ImageDetailCollectionViewCell
        let img = images[indexPath.item]
        cell.fillCell(image: img)
        cell.layoutIfNeeded()
        return cell
    }
}
