//
//  TaskModel.swift
//  UserTasks
//
//  Created by Rida TOUKRICHTE on 29/05/2019.
//

import Foundation

struct TaskModel: Decodable {
    let id: Int?
    let userId: Int?
    let title: String?
    let status: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case title
        case status = "completed"
    }
    
    init(from task: Tasks) {
        self.id = Int(task.id)
        self.title = task.title
        self.userId = Int(task.userId)
        self.status = task.completed
    }
}
