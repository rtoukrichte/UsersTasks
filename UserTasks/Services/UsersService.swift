//
//  UsersService.swift
//  UserTasks
//
//  Created by Nabil EL KHADDARI on 29/05/2019.
//

import Foundation
import Alamofire

class UsersService {
    
    let userProvider: DataProvider
    let userTasksProvider: UserTasksProvider = UserTasksProvider()
    // MARK: - singleton instance
    static let sharedInstance = UsersService(userProvider: DataProvider())
    
    private init(userProvider: DataProvider) {
        self.userProvider = userProvider
    }
    
    lazy var manager = NetworkReachabilityManager(host: "jsonplaceholder.typicode.com")
    
    // MARK: - Load Informations From users WebService
    func loadUsers(completionHandler:@escaping (Bool, [Users.utilisateur]?) -> ()) {
        
        Alamofire.request(Constants.usersListUrl, encoding: URLEncoding.default)
            .responseJSON { response in
                var users = [Users.utilisateur]()
                switch response.result {
                case .success:
                    print("@@@@@@ case Success")
                    if let result = response.data {
                        do {
                            users = try JSONDecoder().decode([Users.utilisateur].self, from: result)
                            print("array of users ==== ", users)
                            
//                            self.userProvider.save(users: users, completion: { state in
//                                guard state else {
//                                    return
//                                }
//                                print("users saved successfully")
//                                completionHandler(true, users)
//
//                            })
                            
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
    func loadTasksUser(userId: Int, completionHandler:@escaping (Bool, [Tasks]?) -> ()) {
        
        let url = Constants.tasksListUrl + "\(userId)"
        Alamofire.request(url, encoding: URLEncoding.default)
            .responseJSON { response in
                var tasks = [Tasks]()
                switch response.result {
                case .success:
                    print("@@@@@@ case Success")
                    if let result = response.data {
                        do {
                            tasks = try JSONDecoder().decode([Tasks].self, from: result)
                            print("array of users ==== ", tasks)
                            
//                            self.userTasksProvider.saveTasks(userId: userId,tasks: tasks, completion: { state in
//                                guard state else {
//                                    return
//                                }
//                                print("users saved successfully")
//                                completionHandler(true, tasks)
//                                
//                            })
                            
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
