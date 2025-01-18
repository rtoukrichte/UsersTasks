//
//  Constants.swift
//  UserTasks
//
//  Created by Rida TOUKRICHTE on 28/05/2019.
//

import Foundation

struct Constants {
    // http://localhost:8080/api/v1
    static let baseUrl      = "https://jsonplaceholder.typicode.com"
    static let usersListUrl = Constants.baseUrl + "/users"
    static let tasksListUrl = Constants.baseUrl + "/todos?userId="
}

var GlobalMainQueue: DispatchQueue {
    return DispatchQueue.main
}

var GlobalBackgroundQueue: DispatchQueue {
    return DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
}
