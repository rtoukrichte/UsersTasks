//
//  User.swift
//  UserTasks
//
//  Created by Rida TOUKRICHTE on 29/05/2019.
//

import Foundation

struct UserModel: Decodable {
    //let id: UUID
    let id: Int
    let name: String?
    let username: String?
    let email: String?
    let phone: String?
    
}

typealias Users = [UserModel]
