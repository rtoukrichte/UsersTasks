//
//  TaskModel.swift
//  UserTasks
//
//  Created by Rida TOUKRICHTE on 29/05/2019.
//

import Foundation

struct Task: Decodable {
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
}
