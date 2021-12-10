//
//  DataProvider.swift
//  UserTasks
//
//  Created by Rida TOUKRICHTE on 30/05/2019.
//

import Foundation

struct UserTasksKeys {
    static let ClassKey = "UsersData"
}

class DataProvider {

    var users: [Users.user]!
    let defaults = UserDefaults.standard

    init() {
        self.fetchData()
    }

    // MARK: - Get information
    func fetchData() {
        if let data = defaults.object(forKey: UserTasksKeys.ClassKey) {
            do {
                users = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as! Data) as? [Users.user]
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }

    // MARK: - Saving information
    func save(users: [Users.user], completion: (Bool) -> Void) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: users, requiringSecureCoding: false)

            defaults.set(data, forKey: UserTasksKeys.ClassKey)
            defaults.synchronize()
            completion(true)
        } catch let error {
            print("Error == ", error.localizedDescription)
            completion(false)
        }
    }

}
