//
//  RedditData.swift
//  IquiiGallery
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//

import Foundation

class RedditData: Codable {
    let childrens: [Children]?

    private enum CodingKeys: String, CodingKey {
        case childrens = "children"
    }
}
