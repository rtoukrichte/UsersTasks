//
//  User.swift
//  UserTasks
//
//  Created by Nabil EL KHADDARI on 29/05/2019.
//

import Foundation

enum Users {
    
    struct List: Codable {
        var users: [utilisateur]?
        
    }
    
    struct utilisateur: Codable {
        var id: Int?
        var name: String?
        var username: String?
        var email: String?
    }
}
