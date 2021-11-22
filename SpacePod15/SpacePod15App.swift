//
//  SpacePod15App.swift
//  SpacePod15
//
//  Created by Mattia Fochesato on 15/11/21.
//

import SwiftUI

@main

struct SpacePod15App: App {
    @StateObject var dataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                TasksView()
                    .tabItem {
                        Label("Tasks", systemImage: "checklist")
                    }
                TrackerView()
                    .tabItem {
                        Label("Journal", systemImage: "book.closed.fill")
                    }
                AwardsView()
                    .tabItem {
                        Label("Awards", systemImage: "sparkle")
                    }
            }
            .accentColor(Color("AccentColor"))
            .environmentObject(dataManager)
        }
    }
}
