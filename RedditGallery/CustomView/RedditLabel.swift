//
//  RedditLabel.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 18/11/20.
//

import UIKit

protocol RedditLabelDelegate: AnyObject {
    func setFontSize() -> CGFloat
}

class RedditLabel: UILabel {

        weak var delegate: RedditLabelDelegate?

        override func awakeFromNib() {
            self.font = FontBook.Bold.of(size: delegate?.setFontSize() ?? 15)
        }
        
        override func layoutSubviews() {
            self.font = FontBook.Bold.of(size: delegate?.setFontSize() ?? 15)
        }
}
