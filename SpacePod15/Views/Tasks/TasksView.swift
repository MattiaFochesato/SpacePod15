//
//  ContentView.swift
//  SpacePod15
//
//  Created by Mattia Fochesato on 15/11/21.
//

import SwiftUI

struct TasksView: View {
    @EnvironmentObject var dataManager: DataManager
    
    @State var showEditTaskView = false
    var body: some View {
        NavigationView {
            VStack {
                if dataManager.tasks.count == 0 {
                    VStack{
                        Image("testAward")
                        Text("Hurray!")
                        Text("You don’t have any task.")
                    }
                }else{
                    ScrollView {
                        VStack {
                            ForEach(dataManager.tasks, id: \.self) { task in
                                Text(task.name)
                                Divider()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Tasks")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        showEditTaskView.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill" )
                    }
                    ).sheet(isPresented: $showEditTaskView){
                        EditTaskView(showEditTaskView: $showEditTaskView)
                    }
                }
            }
            
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
            .environmentObject(DataManager())
    }
}
