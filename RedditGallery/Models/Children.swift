//
//  Children.swift
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//
import Foundation

class Children: Codable {
    var subreddit: String? = nil
    var authorFullname: String? = nil
    var title: String? = nil
    var preview: Preview? = nil
    
    private enum RootCodingKeys: String, CodingKey {
        case data = "data"
    
        enum NestedCodingKeys: String, CodingKey {
            case preview = "preview"
            case subreddit = "subreddit"
            case authorFullname = "author_fullname"
            case name = "name"
            case title = "title"
        }
    }
    
    required public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let imgsDataContainer = try rootContainer.nestedContainer(keyedBy: RootCodingKeys.NestedCodingKeys.self, forKey: .data)

        preview = try imgsDataContainer.decodeIfPresent(Preview.self, forKey: .preview)
        subreddit = try imgsDataContainer.decode(String.self, forKey: .subreddit)
        authorFullname = try imgsDataContainer.decode(String.self, forKey: .authorFullname)
        title = try imgsDataContainer.decode(String.self, forKey: .title)
    }

    func encode(to encoder: Encoder) throws {
        
    }
}
