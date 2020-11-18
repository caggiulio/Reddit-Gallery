//
//  Images.swift
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//
import Foundation

class Images: Codable {

	let resolutions: [Resolutions]?
	let id: String?
    var title: String? = nil
    var author: String? = nil
    
    private enum RootCodingKeys: String, CodingKey {
            case resolutions = "resolutions"
            case id = "id"
    }
    
    required public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        resolutions = try rootContainer.decodeIfPresent([Resolutions].self, forKey: .resolutions)
        id = try rootContainer.decodeIfPresent(String.self, forKey: .id)
    }
    
    
}
