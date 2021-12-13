//
//  User.swift
//  UserTasks
//
//  Created by Rida TOUKRICHTE on 29/05/2019.
//

import Foundation

struct UserModel: Decodable {
    let users: [user]?

    struct user: Decodable {
        let id: Int?
        let name: String?
        let username: String?
        let email: String?
        
        
        init(from user: User) {
            self.id = Int(user.id)
            self.name = user.name
            self.username = user.username
            self.email = user.email
        }
    }
    
    func initFromCoreData(users: [User]) -> [UserModel.user] {
        var results = [UserModel.user]()
        
        for user in users {
            let item = UserModel.user.init(from: user)
            results.append(item)
        }
        
        return results
    }
}
