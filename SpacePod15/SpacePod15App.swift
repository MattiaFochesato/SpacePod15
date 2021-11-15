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
                TrackerView()
                    .tabItem {
                        Label("Traker", systemImage: "list.dash")
                    }
                AwardsView()
                    .tabItem {
                        Label("Awards", systemImage: "dollarsign.circle")
                    }
            }.accentColor(Color(red: 1.0, green: 0.505, blue: 0.36, opacity: 1.0))
        }
    }
}
