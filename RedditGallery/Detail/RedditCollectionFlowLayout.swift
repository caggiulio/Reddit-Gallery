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
    
    let width: CGFloat = 350
    let height: CGFloat = 500
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
        return width + minDistanceBeetweenCells
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: width, height: height)
        }
        get {
            return CGSize(width: width, height: height)
        }
    }
}
