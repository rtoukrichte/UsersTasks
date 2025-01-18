//
//  UsersService.swift
//  UserTasks
//
//  Created by Rida TOUKRICHTE on 29/05/2019.
//

import Foundation

enum DataError: Error {
    case invalidData
    case invalidResponse
    case message(_ error: Error?)
}

class UserService {
    
    // MARK: - singleton instance
    static let shared = UserService()
    
    private init() {}
    
    // MARK: - Load Informations From users WebService
    func fetchUsers(completion:@escaping (Result<Users, Error>) -> ()) {
        
        guard let url = URL(string: Constants.usersListUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data else {
                completion(.failure(DataError.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
                completion(.failure(DataError.invalidResponse))
                return
            }
            
            do {
                let users = try JSONDecoder().decode(Users.self, from: data)
                completion(.success(users))
            }
            catch {
                completion(.failure(DataError.message(error)))
            }
            
        }.resume()
    }
    
    
    func fetchTasks(userId: String, completion:@escaping (Result<Tasks, Error>) -> ()) {
        
        guard let url = URL(string: Constants.tasksListUrl+userId) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data else {
                completion(.failure(DataError.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
                completion(.failure(DataError.invalidResponse))
                return
            }
            
            do {
                let users = try JSONDecoder().decode(Tasks.self, from: data)
                completion(.success(users))
            }
            catch {
                completion(.failure(DataError.message(error)))
            }
            
        }.resume()
    }

    
//    // MARK: - Network Reachability
    func isNetworkReachable() -> Bool {
        return true
    }
}
