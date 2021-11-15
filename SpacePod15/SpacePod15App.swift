//
//  SpacePod15App.swift
//  SpacePod15
//
//  Created by Mattia Fochesato on 15/11/21.
//

import SwiftUI

@main
struct SpacePod15App: App {
    var body: some Scene {
        WindowGroup {
            
            TabView {
                TasksView()
                    .tabItem {
                        Label("Tasks", systemImage: "list.dash")
                    }
                
            }
        }
    }
}
