//
//  FavouritesImages+CoreDataProperties.swift
//  
//
//  Created by Nunzio Giulio Caggegi on 18/11/20.
//
//

import Foundation
import CoreData


extension FavouritesImages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouritesImages> {
        return NSFetchRequest<FavouritesImages>(entityName: "FavouritesImages")
    }

    @NSManaged public var id: String?
    @NSManaged public var imageBinary: Data?

}
