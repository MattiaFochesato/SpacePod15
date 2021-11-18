//
//  EditTaskView.swift
//  SpacePod15
//
//  Created by Roberto La Croce on 16/11/21.
//

import Foundation
import SwiftUI


struct EditTaskView: View {
    @EnvironmentObject var dataManager: DataManager
    
    @Binding var showEditTaskView : Bool
    
    @State private var name: String = ""
    @State private var taskEmoji: String = ""
    @State private var priority: Int = 0
    @State private var completed: Bool = false
    @State private var date = Date()
    
    @State private var dateToggled = false
    
    var subjects = ["Italiano", "Matematica", "Latino", "Scienze"]
    @State private var selectedSubject = "Italiano"
    var body: some View {
        
        NavigationView {
            VStack{
                Picker("Please choose a subject", selection: $selectedSubject) {
                    ForEach(subjects, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.wheel)
                .background(Color(red: 0.951, green: 0.951, blue: 0.98, opacity: 1.0))
                .cornerRadius(20)
                .shadow(radius: 5, x: 5, y: 5)
                Spacer()
                List {
                    Section{
                        TextField("Insert the Task Name", text: $name)
                    }
                    Section(header: Text("Priority")){
                        HStack{
                            VStack{
                                Button {
                                    priority = 0
                                } label: {
                                    Label("None", systemImage: "circle.fill")
                                }
                            }
                            VStack{
                                Button {
                                    priority = 1
                                } label: {
                                    Label("None", systemImage: "circle.fill")
                                }
                            }
                            VStack{
                                Button {
                                    priority = 2
                                } label: {
                                    Label("None", systemImage: "circle.fill")
                                }
                            }
                            VStack{
                                Button {
                                    priority = 3
                                } label: {
                                    Label("None", systemImage: "circle.fill")
                                }
                            }
                        }
                    }
                    Section {
                        Toggle("Date", isOn: $dateToggled)
                        
                        if dateToggled {
                            DatePicker(
                                "",
                                selection: $date,
                                displayedComponents: [.date]
                            )
                        }
                    }
                }
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    Button("Done", action: {
                showEditTaskView.toggle()
                let newTask = TaskInfo(id: UUID(), name: name, taskEmoji: taskEmoji, priority: priority, completed: completed, date: date)
                dataManager.tasks.append(newTask)
            }))
        }
    }
}



struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(showEditTaskView: .constant(true))
    }
}
