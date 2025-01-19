//
//  User.swift
//  UserTasks
//
//  Created by Rida TOUKRICHTE on 29/05/2019.
//

import Foundation

struct UserModel: Decodable, Identifiable {
    //let id: UUID
    let id: Int
    let name: String?
    let username: String?
    let email: String?
    let phone: String?
    let address: Address
    
}

struct Address: Decodable {
    let street: String?
    let city: String?
    let suite: String?
    let zipcode: String?
    let geo: Coordinates
}

struct Coordinates: Decodable {
    let latitude: String?
    let longitude: String?
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}

typealias Users = [UserModel]
