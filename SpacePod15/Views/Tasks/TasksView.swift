//
//  ContentView.swift
//  SpacePod15
//
//  Created by Mattia Fochesato on 15/11/21.
//

import SwiftUI

struct TasksView: View {
    @EnvironmentObject var tasksManager: TasksManager
    
    @State var buttonTap = false
    var body: some View {
        NavigationView {
            ScrollView {
                if tasksManager.tasks.count == 0 {
                    VStack{
                        Text("Hurray!")
                        Text("You don’t have any task.")
                    }
                }else{
                    VStack {
                        ForEach(tasksManager.tasks, id: \.self) { task in
                            Text(task.name)
                            Divider()
                        }
                    }
                }
            }
            .navigationTitle("Tasks")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        tasksManager.tasks.append(TaskInfo(name: "NewTask"))
                        buttonTap.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill" )
                    }
                    ).sheet(isPresented: $buttonTap){
                        EditTaskView()
                    }
                }
            }
            
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
