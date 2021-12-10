//
//  User.swift
//  UserTasks
//
//  Created by Rida TOUKRICHTE on 29/05/2019.
//

import Foundation

struct Users: Decodable {
    let users: [user]?

    struct user: Decodable {
        let id: Int?
        let name: String?
        let username: String?
        let email: String?
    }
}
