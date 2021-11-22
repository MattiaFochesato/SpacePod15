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
                        Label("Tasks", systemImage: "list.dash")
                    }
                TrackerView()
                    .tabItem {
                        Label("Traker", systemImage: "checklist")
                    }
                AwardsView()
                    .tabItem {
                        Label("Awards", systemImage: "cup.and.saucer.fill")
                    }
            }
            .accentColor(Color("AccentColor"))
            .environmentObject(dataManager)
        }
    }
}
