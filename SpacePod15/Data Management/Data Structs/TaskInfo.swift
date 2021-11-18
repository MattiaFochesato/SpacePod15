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
    var name: String
    var taskEmoji: String
    var priority: Int
    var completed: Bool
    var date: Date?
}
