//
//  TaskModel.swift
//  UserTasks
//
//  Created by Nabil EL KHADDARI on 29/05/2019.
//

import Foundation

struct Tasks: Decodable {
    var id: Int
    var userId: Int
    var title: String
    var status: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case title
        case status = "completed"
    }
}
