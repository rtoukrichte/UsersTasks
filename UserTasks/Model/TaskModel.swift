//
//  TaskModel.swift
//  UserTasks
//
//  Created by Rida TOUKRICHTE on 29/05/2019.
//

import Foundation

struct TaskModel: Decodable, Identifiable {
    let id: Int
    let userID: Int
    let title: String?
    let status: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case title
        case status = "completed"
    }
}

typealias Tasks = [TaskModel]
