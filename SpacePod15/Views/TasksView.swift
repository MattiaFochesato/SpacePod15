//
//  ContentView.swift
//  SpacePod15
//
//  Created by Mattia Fochesato on 15/11/21.
//

import SwiftUI

struct TasksView: View {
    var body: some View {
        NavigationView {
            VStack{
            Text("Hello, world!")
                .padding()
        }.navigationTitle("Tasks")
            
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
