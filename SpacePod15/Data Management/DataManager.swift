//
//  DataManager.swift
//  SpacePod15
//
//  Created by Mattia Fochesato on 17/11/21.
//

import Foundation
import Combine
import SwiftUI

class DataManager: ObservableObject {
    
    //UserDefaults key for TaskInfo array
    private static let PREF_JSON_NAME = "app_json_data"
    
    //All the tasks of the app
    @Published var tasks: [TaskInfo] = []
    
    //Init the class
    init() {
        print("[TasksManager] init()")
        //Load tasks from JSON
        self.loadDataFromJson()
        
        
    }
    
    func getDemoDataManager() -> DataManager {
        tasks.append(TaskInfo(id: UUID(), subject: "Italiano", name: "Studia Dante", taskEmoji: "🤌🏻", priority: .low, completed: false, date: nil))
        tasks.append(TaskInfo(id: UUID(), subject: "Italiano", name: "Studia Dante", taskEmoji: "🤌🏻", priority: .low, completed: false, date: nil))
        return self
    }
    
    //Loads the data from the JSON data to restore all the tasks
    func loadDataFromJson() {
        let jsonData = UserDefaults.standard.string(forKey: DataManager.PREF_JSON_NAME)
        
        //Check jsonData is not nil and can be converted to Data
        guard let jsonData = jsonData, let jsonData = jsonData.data(using: .utf8) else {
            tasks = []
            return
        }
        
        //Convert jsonData to [TaskInfo] object
        do {
            //Native class to decode json
            let jsonDecoder = JSONDecoder()
            //Save the extracted tasks
            self.tasks = try jsonDecoder.decode([TaskInfo].self, from: jsonData)
        }catch {
            //Decoding failed. Show error and return
            print("[TasksManager] Cannot decode JSON \(error)")
            tasks = []
            return
        }
        
        print("[TasksManager] Loaded \(tasks.count) tasks from JSON")
    }
    
    //Save all the tasks to the JSON file to keep all the info
    func saveDataToJson() {
        //Native class to encode json
        let jsonEncoder = JSONEncoder()
        
        do {
            //Try to encode all the tasks to a json string
            let jsonData = try jsonEncoder.encode(tasks)
            
            //Extract the String from a Data object
            let json = String(data: jsonData, encoding: .utf8)
            
            //Save the json string to UserDefaults
            UserDefaults.standard.set(json, forKey: DataManager.PREF_JSON_NAME)
        } catch {
            //Encoding failed. Show error
            print("[TasksManager] Cannot encode JSON!")
            return
        }
    }
    
    //Updates the task in the shared list
    func update(task updatedTask: TaskInfo) {
        for index in 0..<tasks.count {
            if tasks[index].id == updatedTask.id {
                tasks[index] = updatedTask
                self.saveDataToJson()
                return
            }
        }
    }
    
    //Delete the task from the shared list
    func delete(task deletedTask: TaskInfo) {
        for index in 0..<tasks.count {
            if tasks[index].id == deletedTask.id {
                tasks.remove(at: index)
                self.saveDataToJson()
                return
            }
        }
    }
    
}
