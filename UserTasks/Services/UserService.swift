//
//  UsersService.swift
//  UserTasks
//
//  Created by Rida TOUKRICHTE on 29/05/2019.
//

import Foundation
import Alamofire


class UserService {
    
    // MARK: - singleton instance
    static let shared = UserService()
    
    private init() {}
    
    lazy var manager = NetworkReachabilityManager(host: "jsonplaceholder.typicode.com")
    
    // MARK: - Load Informations From users WebService
    func loadUsers(completionHandler:@escaping (Bool, [UserModel.user]?) -> ()) {
        
        Alamofire.request(Constants.usersListUrl, encoding: URLEncoding.default)
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    print("@@@@@@ case Success")
                    if let result = response.data {
                        do {
                            let users = try JSONDecoder().decode([UserModel.user].self, from: result)
                            
                            GlobalBackgroundQueue.async {
                                CoreDataManager.shared.saveUsers(users)
                            }
                            
                            completionHandler(true, users)
                        }
                        catch let jsonErr {
                            print("Error" , jsonErr)
                            completionHandler(true, nil)
                        }
                        
                    } else {
                        completionHandler(false, nil)
                    }
                    break
                case .failure(let error):
                    print("@@@@@@@ Error == ", error.localizedDescription)
                    completionHandler(false, nil)
                    break
                }
        }
    }
    
    // 
    func loadTasksUser(userId: Int, completionHandler:@escaping (Bool, [TaskModel]?) -> ()) {
        
        let url = Constants.tasksListUrl + "\(userId)"
        
        Alamofire.request(url, encoding: URLEncoding.default)
            .responseJSON { response in

                switch response.result {
                case .success:
                    print("@@@@@@ case Success")
                    if let result = response.data {
                        do {
                            let tasks = try JSONDecoder().decode([TaskModel].self, from: result)
                            //print("array of users ==== ", tasks)
                            
                            GlobalBackgroundQueue.async {
                                CoreDataManager.shared.saveTasks(tasks, userId: userId)
                            }
                            
                            completionHandler(true, tasks)
                        }
                        catch let jsonErr {
                            print("Error" , jsonErr)
                            completionHandler(true, nil)
                        }
                        
                    } else {
                        completionHandler(false, nil)
                    }
                    break
                case .failure(let error):
                    print("@@@@@@@ Error == ", error.localizedDescription)
                    completionHandler(false, nil)
                    break
                }
        }
    }
    
    // MARK: - Network Reachability
    func isNetworkReachable() -> Bool {
        return manager?.isReachable ?? false
    }
}
