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
                                        .foregroundColor(task.priority == .low ? Color("AccentColor") : Color(red: 0.901, green: 0.901, blue: 0.91, opacity: 1.0))
                                    
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
                                        .foregroundColor(task.priority == .medium ? Color("AccentColor") : Color(red: 0.901, green: 0.901, blue: 0.91, opacity: 1.0))
                                    
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
                                        .foregroundColor(task.priority == .high ? Color("AccentColor") : Color(red: 0.901, green: 0.901, blue: 0.91, opacity: 1.0))
                                    
                                    Image(systemName: "nosign")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 30, height: 30)
                                }
                                .frame(width: 45, height: 45)
                            }.frame(minWidth: 0, maxWidth: .infinity)
                        }
                    }
                    if !task.completed {
                        Section {
                            Button {
                                let generator = UINotificationFeedbackGenerator()
                                generator.notificationOccurred(.success)
                                
                                task.completed = true
                                dataManager.update(task: task)
                                
                                presentationMode.wrappedValue.dismiss()
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
        TappedTask(task: TaskInfo(id: UUID(), subject: "Italiano", name: "Studia Foscolo", taskEmoji: "📕", priority: .medium, completed: false, date: Date()))
    }
}
