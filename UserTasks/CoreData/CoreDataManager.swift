//
//  CoreDataManager.swift
//  UserTasks
//
//  Created by rtoukrichte on 10/12/2021.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    static let shared = CoreDataManager()
    private override init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "UserTasks")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context : NSManagedObjectContext {
        CoreDataManager.shared.persistentContainer.viewContext
    }
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
                print("save success coredata")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    /**
     Create a new record into the table
     
     :return: New object instance created
     */
//    func `new`<[Entity] : NSManagedObject>()
//    {
//        let items = [Entity] as? [Entity]
////        guard let entity: Entity = NSEntityDescription.insertNewObject(forEntityName: String(describing: Entity.self), into: context) as? Entity else {
////            fatalError("Unable to instanciate entity '\(String(describing: Entity.self))'")
////        }
//
//        for entity in items {
//            NSEntityDescription.insertNewObject(forEntityName: String(describing: Entity.self), into: context) as? Entity
//        }
//
//        //return entity
//    }
    
    func saveUsers(items: [User]) {
        for item in items {
            let new = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as? User
            
            new?.setValue(item.id, forKey: "id")
            new?.setValue(item.name, forKey: "name")
            new?.setValue(item.username, forKey: "username")
            new?.setValue(item.email, forKey: "email")
        }
        save()
    }
    
    func getAll<T: NSManagedObject> (_ id : NSManagedObjectID) -> T? {
        do {
            return try context.existingObject(with: id) as? T
        } catch {
            print(error)
        }
        return nil
    }
    
    func fetchUsers() -> [User]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        //let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        //fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let objects = try context.fetch(fetchRequest)
            return objects as? [User]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func delete(_ object: NSManagedObject){
        do {
            context.delete(object)
        } catch {
            print("error from deleting")
        }
        save()
    }
    
}


extension NSManagedObjectContext{
    func fetchObjects <T: NSManagedObject>(_ entityClass:T.Type,
                                           sortBy: [NSSortDescriptor]? = nil,
                                           predicate: NSPredicate? = nil) throws -> [T] {
        
        let request: NSFetchRequest<T>
        if #available(iOS 10.0, *) {
            request = entityClass.fetchRequest() as! NSFetchRequest<T>
        } else {
            let entityName = String(describing: entityClass)
            request = NSFetchRequest(entityName: entityName)
        }
        
        request.returnsObjectsAsFaults = false
        request.predicate = predicate
        request.sortDescriptors = sortBy
        
        let fetchedResult = try self.fetch(request)
        return fetchedResult
    }
}
