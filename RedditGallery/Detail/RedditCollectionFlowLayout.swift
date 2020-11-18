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
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
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
        return 350 + 10
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: 350, height: 550)
        }
        get {
            return CGSize(width: 350, height: 550)
        }
    }
}
