//
//  TappedTask.swift
//  SpacePod15
//
//  Created by Tommaso Barbiero on 19/11/21.
//

import SwiftUI

struct TappedTask: View {
    
    @EnvironmentObject var dataManager: DataManager
    
    var task : TaskInfo
    
    @State private var priority: TaskPriority = .noPriority
    
    var body: some View {
        //NavigationView {
            VStack {
                List {
                    Section {
                        Text("\(task.name)")
                    }
                    Section("Date") {
                        Text("data selezionata")
                    }
                    Section("Priority") {
                        HStack(spacing : 0) {
                            VStack {
                                ZStack {
                                    Circle()
                                        .foregroundColor(priority == .noPriority ? Color("AccentColor") : Color(red: 0.901, green: 0.901, blue: 0.91, opacity: 1.0))
                                    
                                    Image(systemName: "nosign")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 30, height: 30)
                                }
                                .frame(width: 45, height: 45)
                            }.frame(minWidth: 0, maxWidth: .infinity)
                            VStack {
                                ZStack {
                                    Circle()
                                        .foregroundColor(priority == .low ? Color("AccentColor") : Color(red: 0.901, green: 0.901, blue: 0.91, opacity: 1.0))
                                    
                                    Image(systemName: "nosign")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 30, height: 30)
                                }
                                .frame(width: 45, height: 45)
                            }.frame(minWidth: 0, maxWidth: .infinity)
                            VStack {
                                ZStack {
                                    Circle()
                                        .foregroundColor(priority == .medium ? Color("AccentColor") : Color(red: 0.901, green: 0.901, blue: 0.91, opacity: 1.0))
                                    
                                    Image(systemName: "nosign")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 30, height: 30)
                                }
                                .frame(width: 45, height: 45)
                            }.frame(minWidth: 0, maxWidth: .infinity)
                            VStack {
                                ZStack {
                                    Circle()
                                        .foregroundColor(priority == .high ? Color("AccentColor") : Color(red: 0.901, green: 0.901, blue: 0.91, opacity: 1.0))
                                    
                                    Image(systemName: "nosign")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 30, height: 30)
                                }
                                .frame(width: 45, height: 45)
                            }.frame(minWidth: 0, maxWidth: .infinity)
                        }
                    }
                    Section {
                        Button {
                            
                        } label: {
                            Text("Complete Task")
                                .foregroundColor(Color("AccentColor"))
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }
                    }
                    Section {
                        Button {
                            
                        } label: {
                            Text("Delete Task")
                                .foregroundColor(Color("Delete"))
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }
                    }
                }.listStyle(InsetGroupedListStyle())
            //}
            .navigationBarTitle(Text("Task Info"), displayMode: .inline)
            /*.navigationBarItems(trailing:
                                    Button(action: {
                
            }, label: {
                Text("Done")
            })
            )*/
        }
    }
}

struct TappedTask_Previews: PreviewProvider {
    static var previews: some View {
        TappedTask(task: TaskInfo(id: UUID(), subject: "Italiano", name: "Studia Foscolo", taskEmoji: "📕", priority: .medium, completed: false, date: nil))
    }
}
