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
                        VStack(spacing: 0) {
                            ForEach(dataManager.tasks, id: \.self) { task in
                              NavigationLink {
                                    TappedTask(task: task)
                                } label: {
                                    TaskRow(task: task)
                                        .cornerRadius(10)
                                        .padding([.leading, .trailing])
                                        .padding([.top, .bottom], 10)
                                        .shadow(radius: 10)
                                }.buttonStyle(ScaleButtonStyle())
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

struct TaskRow: View {
    var task: TaskInfo
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                
                if task.priority != .noPriority {
                    Image(systemName: "exclamationmark\(task.priority != .low ? ".\(task.priority.rawValue)" : "")")
                        .resizable()
                        .font(Font.title.weight(.bold))
                        .foregroundColor(.white)
                              .aspectRatio(contentMode: .fit)
                              .frame(width: 20, height: 20)
                              .frame(width: 40, height: 40)
                              .background(Color.secondary)
                              .clipShape(Circle())
                              .padding([.trailing, .top], 8)
                }
                
            }
            Spacer()
            Text(task.name)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .bottom], 16)
        }.frame(height: 150)
            .frame(maxWidth: .infinity)
            .background(.gray)
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
            .environmentObject(DataManager().getDemoDataManager())
    }
}
