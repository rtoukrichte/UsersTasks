//
//  UserTasksProvider.swift
//  UserTasks
//
//  Created by Nabil EL KHADDARI on 30/05/2019.
//

import Foundation

struct TasksKeys {
    static let ClassKey = "TasksData"
}

class UserTasksProvider {
    
    var tasks: [Task]!
    
//    init(userId: Int) {
//        self.fetchTasks(userId: userId)
//    }
    
    // MARK: - Get information
    func fetchTasks(userId: Int)  {
        
        if let data = UserDefaults.standard.object(forKey: TasksKeys.ClassKey) as? Dictionary<String, Any> {
            let userTasks = NSKeyedUnarchiver.unarchiveObject(with: data["\(userId)"] as! Data) as! [Task]
            for task in userTasks {
                if task.userId == userId{
                    tasks.append(task)
                }
            }
        }
        
    }
    
    // MARK: - Saving information
    func saveTasks(userId: Int, tasks: [Task], completion: (Bool) -> Void) {
        
        let dic = ["\(userId)": tasks]
        let data = NSKeyedArchiver.archivedData(withRootObject: dic)
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: TasksKeys.ClassKey)
        defaults.synchronize()
        completion(true)
    }
    
}
