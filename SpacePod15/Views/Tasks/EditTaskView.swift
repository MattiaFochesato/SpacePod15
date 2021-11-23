//
//  EditTaskView.swift
//  SpacePod15
//
//  Created by Roberto La Croce on 16/11/21.
//

import Foundation
import SwiftUI
import Combine

private enum FocusedField: Int, Hashable {
    case name
}
struct EditTaskView: View {
    @EnvironmentObject var dataManager: DataManager
    
    @Binding var showEditTaskView : Bool
    @State private var showingErrorAlert = false
    
    private var taskToEdit: TaskInfo? = nil
    
    var subjects = Subject.subjects.map { subject in subject.name }
    
    @State private var selectedSubject = Subject.subjects.first!.name
    @State private var taskName: String = ""
    @State private var taskEmoji: String = ""
    
    @State private var priority: TaskPriority = .low
    
    @State private var dateToggled = false
    @State private var date: Date = Date()
    
    init(showEditTaskView: Binding<Bool>, taskToEdit: TaskInfo?) {
        self._showEditTaskView = showEditTaskView
        
        self.taskToEdit = taskToEdit
        
        if let taskToEdit = taskToEdit {
            self._selectedSubject = State(initialValue: taskToEdit.subject)
            self._taskName = State(initialValue: taskToEdit.name)
            self._taskEmoji = State(initialValue: taskToEdit.taskEmoji)
            self._priority = State(initialValue: taskToEdit.priority)
            self._date = State(initialValue: taskToEdit.date ?? Date())
            self._dateToggled = State(initialValue: (taskToEdit.date != nil))
            //self._completed = State(initialValue: taskToEdit.completed)
        }
        
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0){
                /*Picker("Please choose a subject", selection: $selectedSubject) {
                 ForEach(subjects, id: \.self) {
                 Text($0)
                 }
                 }
                 .pickerStyle(.wheel)
                 .background(Color(red: 0.951, green: 0.951, blue: 0.98, opacity: 1.0))*/
                //.cornerRadius(20)
                //.shadow(radius: 5, x: 5, y: 5)
                List {
                    Section(header: Text("Subject")) {
                        Picker("Please choose a subject", selection: $selectedSubject) {
                            ForEach(subjects, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.wheel)
                        //.background(Color(red: 0.951, green: 0.951, blue: 0.98, opacity: 1.0))
                    }
                    Section(header: Text("Task Name")){
                        /*HStack {
                         EmojiTextField(text: $taskEmoji, placeholder: "🤌🏻")
                         .frame(maxWidth: 40)
                         */
                        HStack {
                            /*Image(systemName: "calendar")
                             .resizable()
                             .font(Font.title.weight(.bold))
                             .foregroundColor(.white)
                             .aspectRatio(contentMode: .fit)
                             .frame(width: 20, height: 20)
                             .frame(width: 40, height: 40)
                             .background(Color.blue)
                             .clipShape(RoundedRectangle(cornerRadius: 12))*/
                            TextField("Insert your task name", text: $taskName)
                        }//.listRowInsets(EdgeInsets())
                        // .padding(8)
                        //}
                    }
                    Section(header: Text("Priority")){
                        HStack(spacing: 0){
                            
                            VStack(alignment: .center){
                                Button {
                                    priority = .low
                                } label: {
                                    VStack {
                                        ZStack {
                                            Circle()
                                                .foregroundColor(priority == .low ? Color("Low") : Color("PriorityBadgeBg"))
                                            
                                            Image(systemName: "exclamationmark")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(.white)
                                                .frame(width: 30, height: 30)
                                        }
                                        .frame(width: 45, height: 45)
                                        Text("Low")
                                    }
                                }.buttonStyle(PlainButtonStyle())
                            }.frame(minWidth: 0, maxWidth: .infinity)
                            VStack(alignment: .center){
                                Button {
                                    priority = .medium
                                } label: {
                                    VStack {
                                        ZStack {
                                            Circle()
                                                .foregroundColor(priority == .medium ? Color("Medium") : Color("PriorityBadgeBg"))
                                            
                                            Image(systemName: "exclamationmark.2")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(.white)
                                                .frame(width: 30, height: 30)
                                        }
                                        .frame(width: 45, height: 45)
                                        Text("Medium")
                                    }
                                }.buttonStyle(PlainButtonStyle())
                                
                            }.frame(minWidth: 0, maxWidth: .infinity)
                            VStack(alignment: .center){
                                Button {
                                    priority = .high
                                } label: {
                                    VStack {
                                        ZStack {
                                            Circle()
                                                .foregroundColor(priority == .high ? Color("High") : Color("PriorityBadgeBg"))
                                            
                                            Image(systemName: "exclamationmark.3")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(.white)
                                                .frame(width: 30, height: 30)
                                        }
                                        .frame(width: 45, height: 45)
                                        Text("High")
                                    }
                                }.buttonStyle(PlainButtonStyle())
                                
                            }.frame(minWidth: 0, maxWidth: .infinity)
                        }
                        
                    }
                    Section {
                        Toggle("Date", isOn: $dateToggled)
                        if dateToggled{
                            HStack {
                                Image(systemName: "calendar")
                                    .resizable()
                                    .font(Font.title.weight(.bold))
                                    .foregroundColor(.white)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .frame(width: 40, height: 40)
                                    .background(Color.blue)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                
                                DatePicker(
                                    "",
                                    selection: $date,
                                    displayedComponents: [.date]
                                )
                            }
                        }
                    }
                }.listStyle(InsetGroupedListStyle())
            }
            .navigationTitle(taskToEdit != nil ? "Edit Task" : "New Task")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    Button("Done", action: {
                if taskName.count == 0 {
                    self.showingErrorAlert.toggle()
                    return
                }
                showEditTaskView.toggle()
                let newTask = TaskInfo(id: (taskToEdit == nil ? UUID() : taskToEdit!.id),subject: selectedSubject, name: taskName, taskEmoji: taskEmoji, priority: priority, completed: nil, date: (dateToggled ? date : nil))
                
                if taskToEdit == nil {
                    dataManager.tasks.append(newTask)
                    dataManager.saveDataToJson()
                }else{
                    dataManager.update(task: newTask)
                }
            })
            )
            .alert("Insert the task name", isPresented: $showingErrorAlert) {
                Button("Ok", role: .cancel) { }
            }
            
        }
    }
}
class UIEmojiTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setEmoji() {
        _ = self.textInputMode
    }
    
    override var textInputContextIdentifier: String? {
        return ""
    }
    
    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                self.keyboardType = .default // do not remove this
                return mode
            }
        }
        return nil
    }
}

struct EmojiTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String = ""
    
    func makeUIView(context: Context) -> UIEmojiTextField {
        let emojiTextField = UIEmojiTextField()
        emojiTextField.placeholder = placeholder
        emojiTextField.text = text
        emojiTextField.delegate = context.coordinator
        return emojiTextField
    }
    
    func updateUIView(_ uiView: UIEmojiTextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: EmojiTextField
        
        init(parent: EmojiTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async { [weak self] in
                self?.parent.text = textField.text ?? ""
            }
        }
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(showEditTaskView: .constant(true), taskToEdit: nil)
    }
}
