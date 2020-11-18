
//
//  CoreDataRepo.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 18/11/20.
//

import Foundation
import CoreData
import UIKit

class CoreDataRepo {
    static let shared = CoreDataRepo()
    
    private var context: NSManagedObjectContext
    
    private init() {
        let application = UIApplication.shared.delegate as! AppDelegate
        self.context = application.persistentContainer.viewContext
    }
    
    func addFavouriteImage(id: String, imageData: Data) {
        if IfStored(id: id) {
            return
        }
        let entity = NSEntityDescription.entity(forEntityName: "FavouritesImages", in: self.context)
        
        let img = FavouritesImages(entity: entity!, insertInto: self.context)
        img.id = id
        img.imageBinary = imageData
        
        do {
            try self.context.save()
        } catch let error {
            print(error)
        }
    }
    
    func loadAllImages() -> [FavouritesImages] {
        var fetchingImage = [FavouritesImages]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouritesImages")
        
        do {
            fetchingImage = try context.fetch(fetchRequest) as! [FavouritesImages]
        } catch {
            print("Error while fetching the image")
        }
        
        return fetchingImage
    }
    
    private func loadImagesFromFetchRequest(request: NSFetchRequest<FavouritesImages>) -> [FavouritesImages] {
        var array = [FavouritesImages]()
        do {
            array = try self.context.fetch(request)
                
        } catch let error {
            print(error)
        }
        
        return array
    }
    
    func loadImageFromID(id: String) -> FavouritesImages? {
        let request: NSFetchRequest<FavouritesImages> = NSFetchRequest(entityName: "FavouritesImages")
        request.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "id = %@", id)
        request.predicate = predicate
        
        let users = self.loadImagesFromFetchRequest(request: request)
        if users.count > 0 {
            return users[0]
        } else {
            return nil
        }
    }
    
    func deleteImage(id: String) {
        if let img = self.loadImageFromID(id: id) {
            self.context.delete(img)
            
            do {
                try self.context.save()
            } catch let error {
               print(error)
            }
        }
    }
    
    func IfStored(id: String) -> Bool {
        if let _ = self.loadImageFromID(id: id) {
            return true
        }
        return false
    }
}
