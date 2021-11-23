//
//  TappedTask.swift
//  SpacePod15
//
//  Created by Tommaso Barbiero on 19/11/21.
//

import SwiftUI

struct TappedTask: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showingDeleteConfirmationAlert = false
    @State private var showingEditSheet = false
    
    @EnvironmentObject var dataManager: DataManager
    
    @State var task : TaskInfo
    
    var body: some View {
        //NavigationView {
            VStack {
                List {
                    Section {
                        Text("\(task.name)")
                    }
                    
                    if let date = task.date {
                        Section("Date") {
                            Text(date.prettyPrint())
                            /*DatePicker("",
                                       selection: .constant(date),
                                       displayedComponents: [.date])
                                .disabled(true)*/
                        }
                    }
                    
                    Section("Priority") {
                        HStack(spacing : 0) {
                            VStack {
                                ZStack {
                                    Circle()
                                        .foregroundColor(task.priority == .low ? Color("Low") : Color("PriorityBadgeBg"))
                                    
                                    Image(systemName: "exclamationmark")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.white)
                                        .frame(width: 30, height: 30)
                                }
                                .frame(width: 45, height: 45)
                            }.frame(minWidth: 0, maxWidth: .infinity)
                            VStack {
                                ZStack {
                                    Circle()
                                        .foregroundColor(task.priority == .medium ? Color("Medium") : Color("PriorityBadgeBg"))
                                    
                                    Image(systemName: "exclamationmark.2")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.white)
                                        .frame(width: 30, height: 30)
                                }
                                .frame(width: 45, height: 45)
                            }.frame(minWidth: 0, maxWidth: .infinity)
                            VStack {
                                ZStack {
                                    Circle()
                                        .foregroundColor(task.priority == .high ? Color("High") : Color("PriorityBadgeBg"))
                                    
                                    Image(systemName: "exclamationmark.3")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.white)
                                        .frame(width: 30, height: 30)
                                }
                                .frame(width: 45, height: 45)
                            }.frame(minWidth: 0, maxWidth: .infinity)
                        }
                    }
                    if task.completed == nil {
                        Section {
                            Button {
                                let generator = UINotificationFeedbackGenerator()
                                generator.notificationOccurred(.success)
                                
                                task.completed = Date()
                                dataManager.update(task: task)
                                
                                presentationMode.wrappedValue.dismiss()
                                
                                dataManager.unlockedAwards.append(UnlockedAward(awardName: "medGeografiaBronzo", date: Date()))
                            } label: {
                                Text("Complete Task")
                                    .foregroundColor(Color("AccentColor"))
                                    .frame(minWidth: 0, maxWidth: .infinity)
                            }
                        }
                    }
                    Section {
                        Button {
                            self.showingDeleteConfirmationAlert.toggle()
                        } label: {
                            Text("Delete Task")
                                .foregroundColor(Color("Delete"))
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }.alert(isPresented: $showingDeleteConfirmationAlert) {
                            Alert(title: Text("Warning"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete"),action:{
                                
                                dataManager.delete(task: task)
                                presentationMode.wrappedValue.dismiss()
                            }), secondaryButton: .cancel(Text("Cancel")))

                        }
                        /*.alert("Wa", isPresented: $showingDeleteConfirmationAlert) {
                            Button("First") { }
                            Button("Second") { }
                        }*/
                    }
                }.listStyle(InsetGroupedListStyle())
            //}
            .navigationBarTitle(Text("Task Info"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button("Edit", action: {
                self.showingEditSheet.toggle()
            }))
            .sheet(isPresented: $showingEditSheet) {
                //Dismiss
                print("Dismissed Edit Task View")
            } content: {
                //Content
                EditTaskView(showEditTaskView: $showingEditSheet, taskToEdit: task)
            }
        }
    }
}

struct TappedTask_Previews: PreviewProvider {
    static var previews: some View {
        TappedTask(task: TaskInfo(id: UUID(), subject: "Italiano", name: "Studia Foscolo", taskEmoji: "📕", priority: .medium, completed: nil, date: Date()))
    }
}
