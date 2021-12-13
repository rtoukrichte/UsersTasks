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
    
    lazy var context : NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
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

    
    func request<T: NSManagedObject>(_ entityClass:T.Type, predicate: NSPredicate? = nil, sorted: [NSSortDescriptor]? = nil, limit: UInt? = nil) -> NSFetchRequest<T>
    {
        let request = NSFetchRequest<T>(entityName: String(describing: entityClass))
        
        if let limit = limit
        {
            request.fetchLimit = Int(limit)
        }
 
        request.predicate = predicate
        request.sortDescriptors = sorted

        return request
    }
    
    func saveUsers(_ items: [UserModel.user]) {
        if self.ifExists(User.self) {
            return
        }
        
        for item in items {
            let new = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as? User
            
            new?.setValue(item.id, forKey: "id")
            new?.setValue(item.name, forKey: "name")
            new?.setValue(item.username, forKey: "username")
            new?.setValue(item.email, forKey: "email")
        }
        save()
    }
    
    func saveTasks(_ items: [TaskModel], userId: Int) {
        
        let predicate = NSPredicate(format: "(userId == %i)", userId)
        if self.ifExists(Tasks.self, where: predicate) {
            return
        }
        
        for item in items {
            let new = NSEntityDescription.insertNewObject(forEntityName: "Tasks", into: context) as? Tasks
            
            new?.setValue(item.id, forKey: "id")
            new?.setValue(item.title, forKey: "title")
            new?.setValue(item.userId, forKey: "userId")
            new?.setValue(item.status, forKey: "completed")
        }
        save()
    }
    
    func fetchTasks(userId: Int) -> [TaskModel]? {
        var results = [TaskModel]()

        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        let predicate = NSPredicate(format: "(userId == %i)", userId)
        
        let request = request(Tasks.self, predicate: predicate, sorted: [sortDescriptor])
        
        do {
            let fetchedObjects = try context.fetch(request)
            fetchedObjects.forEach { item in
                let newItem = TaskModel.init(from: item)
                results.append(newItem)
            }
            print("fetched tasks results count === ", results.count)
            return results
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func fetchUsers() -> [UserModel.user]? {
        var results = [UserModel.user]()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        
        let request = request(User.self, sorted: [sortDescriptor])
        
        do {
            let fetchedData = try context.fetch(request)
            fetchedData.forEach { item in
                let newItem = UserModel.user.init(from: item)
                results.append(newItem)
            }
            print("fetched users results count === ", results.count)
            return results
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        save()
    }
    
    func ifExists<T: NSManagedObject>(_ entityClass:T.Type, where predicate: NSPredicate? = nil) -> Bool {
        return self.count(entityClass, where: predicate) > 0
    }
    
    func count<T: NSManagedObject>(_ entityClass:T.Type, where predicate: NSPredicate? = nil, sorted: [NSSortDescriptor]? = nil, limit: UInt? = nil) -> Int
    {
        do
        {
            return try context.count(for: self.request(entityClass, predicate: predicate, sorted: sorted, limit: limit))
        }
        catch
        {
            print("Request 'count' failed: \(error.localizedDescription)")
            return -1
        }
    }
        
}


extension NSManagedObjectContext {
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
        
        do {
            let fetchedResult = try self.fetch(request)
            return fetchedResult
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
}
