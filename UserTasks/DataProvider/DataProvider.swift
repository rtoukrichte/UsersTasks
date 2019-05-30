//
//  DataProvider.swift
//  UserTasks
//
//  Created by Nabil EL KHADDARI on 30/05/2019.
//

import Foundation

struct UserTasksKeys {
    static let ClassKey    = "UsersData"
}

class DataProvider {
    
    var users: [Users.utilisateur]!
    
    init() {
        self.fetchData()
    }
    
    // MARK: - Get information
    func fetchData()  {
        
        if let data = UserDefaults.standard.object(forKey: UserTasksKeys.ClassKey) {
            //users = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? [Users.utilisateur]
            
            users = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as! Data) as? [Users.utilisateur]
        }
    }
    
    // MARK: - Saving information
    func save(users: [Users.utilisateur], completion: (Bool) -> Void) {
        
        //let data = NSKeyedArchiver.archivedData(withRootObject: users)
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: users, requiringSecureCoding: true)
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: UserTasksKeys.ClassKey)
            defaults.synchronize()
            completion(true)
        } catch let error {
            print("Error == ", error.localizedDescription)
        }
        
    }
    
}
