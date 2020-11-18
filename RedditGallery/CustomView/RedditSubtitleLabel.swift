//
//  RedditSubtitleLabel.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 18/11/20.
//

import UIKit

protocol RedditSubtitleLabelDelegate: AnyObject {
    func setFontSize() -> CGFloat
}

class RedditSubtitleLabel: UILabel {

        weak var delegate: RedditSubtitleLabelDelegate?

        override func awakeFromNib() {
            self.font = FontBook.Bold.of(size: delegate?.setFontSize() ?? 12)
        }
        
        override func layoutSubviews() {
            self.font = FontBook.Bold.of(size: delegate?.setFontSize() ?? 12)
        }
}
