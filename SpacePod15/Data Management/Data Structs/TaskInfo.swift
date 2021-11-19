//
//  TaskInfo.swift
//  SpacePod15
//
//  Created by Mattia Fochesato on 17/11/21.
//

import Foundation
import Combine

//Task Info Structure
struct TaskInfo: Codable, Hashable, Identifiable {
    var id: UUID
    var subject: String
    var name: String
    var taskEmoji: String
    var priority: TaskPriority
    var completed: Bool
    var date: Date?
}

enum TaskPriority: Int, Codable {
    case noPriority = 0
    case low = 1
    case medium = 2
    case high = 3
}
