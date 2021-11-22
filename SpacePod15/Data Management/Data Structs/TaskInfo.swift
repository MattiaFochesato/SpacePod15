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
    case low = 0
    case medium = 1
    case high = 2
}
