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
    var thumbnailHeight: Int? = nil
    var thumbnailWidth: Int? = nil
    var thumbnail: String? = nil
    var preview: Preview? = nil
    
    private enum RootCodingKeys: String, CodingKey {

            case data = "data"
        
            enum NestedCodingKeys: String, CodingKey {
                case preview = "preview"
                case subreddit = "subreddit"
                case authorFullname = "author_fullname"
                case thumbnailHeight = "thumbnail_height"
                case name = "name"
                case thumbnailWidth = "thumbnail_width"
                case thumbnail = "thumbnail"
                case title = "title"
            }
        }
    
    required public init(from decoder: Decoder) throws {

        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let userDataContainer = try rootContainer.nestedContainer(keyedBy: RootCodingKeys.NestedCodingKeys.self, forKey: .data)

        preview = try userDataContainer.decodeIfPresent(Preview.self, forKey: .preview)
        subreddit = try userDataContainer.decode(String.self, forKey: .subreddit)
        authorFullname = try userDataContainer.decode(String.self, forKey: .authorFullname)
        thumbnailHeight = try userDataContainer.decodeIfPresent(Int.self, forKey: .thumbnailHeight)
        thumbnailWidth = try userDataContainer.decodeIfPresent(Int.self, forKey: .thumbnailWidth)
        thumbnail = try userDataContainer.decodeIfPresent(String.self, forKey: .thumbnail)
        title = try userDataContainer.decode(String.self, forKey: .title)
    }

    func encode(to encoder: Encoder) throws {
        
    }
}
