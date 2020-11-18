//
//  FontBook.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 18/11/20.
//

import Foundation
import UIKit

enum FontBook: String {
    case Medium = "Futura"
    case Bold = "Futura-Bold"
    
    func of(size: CGFloat) -> UIFont {
        return UIFont.init(name: self.rawValue, size: size)!
    }
}
