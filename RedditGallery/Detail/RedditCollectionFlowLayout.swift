//
//  RedditCollectionFlowLayout.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 18/11/20.
//

import UIKit

class RedditCollectionFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        self.scrollDirection = .horizontal
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    let size = UIDevice.current.userInterfaceIdiom == .phone ? CGSize.init(width: 350, height: 500) : CGSize.init(width: 600, height: 900)
    
    let minDistanceBeetweenCells: CGFloat = 10
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }

        // Calculate width of your page
        let pageWidth = calculatedPageWidth()

        // Calculate proposed page
        let proposedPage = round(proposedContentOffset.x / pageWidth)

        // Adjust necessary offset
        let xOffset = pageWidth * proposedPage - collectionView.contentInset.left

        return CGPoint(x: xOffset, y: 0)
    }

    func calculatedPageWidth() -> CGFloat {
        return size.width + minDistanceBeetweenCells
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: size.width, height: size.height)
        }
        get {
            return CGSize(width: size.width, height: size.height)
        }
    }
}
