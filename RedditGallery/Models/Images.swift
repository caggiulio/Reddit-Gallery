//
//  Images.swift
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//
import Foundation

public class Images: Codable, Equatable {

	let resolutions: [Resolutions]?
	let id: String?
    var title: String? = nil
    var author: String? = nil
    var isPreferred: Bool = false
    
    private enum RootCodingKeys: String, CodingKey {
            case resolutions = "resolutions"
            case id = "id"
    }
    
    required public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        resolutions = try rootContainer.decodeIfPresent([Resolutions].self, forKey: .resolutions)
        id = try rootContainer.decodeIfPresent(String.self, forKey: .id)
        if let id = id {
            isPreferred = CoreDataRepo.IfStored(id: id)
        }
    }
    
    static public func ==(lhs: Images, rhs: Images) -> Bool {
        return lhs.id == rhs.id
    }
    
}
