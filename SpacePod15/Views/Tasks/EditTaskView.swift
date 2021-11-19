//
//  EditTaskView.swift
//  SpacePod15
//
//  Created by Roberto La Croce on 16/11/21.
//

import Foundation
import SwiftUI
import Combine


struct EditTaskView: View {
    @EnvironmentObject var dataManager: DataManager
    
    @Binding var showEditTaskView : Bool
    
    
    var subjects = ["Italiano", "Matematica", "Latino", "Scienze"]
    
    @State private var selectedSubject = ""
    @State private var taskName: String = ""
    @State private var taskEmoji: String = ""
    
    @State private var priority: TaskPriority = .noPriority
    
    @State private var dateToggled = false
    @State private var date = Date()
    
    @State private var completed: Bool = false
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 0){
                Picker("Please choose a subject", selection: $selectedSubject) {
                    ForEach(subjects, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.wheel)
                .background(Color(red: 0.951, green: 0.951, blue: 0.98, opacity: 1.0))
                //.cornerRadius(20)
                //.shadow(radius: 5, x: 5, y: 5)
                List {
                    Section{
                        HStack {
                            EmojiTextField(text: $taskEmoji, placeholder: "🤌🏻")
                                .frame(maxWidth: 40)
                            
                            TextField("Task Name", text: $taskName)
                        }
                    }
                    Section(header: Text("Priority")){
                        HStack(spacing: 0){
                            VStack(alignment: .leading){
                                Button {
                                    priority = .noPriority
                                } label: {
                                    
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
                                        Text("None")
                                    }
                                }.buttonStyle(PlainButtonStyle())
                                
                                
                            }.frame(minWidth: 0, maxWidth: .infinity)
                            VStack(alignment: .center){
                                Button {
                                    priority = .low
                                } label: {
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
                                                .foregroundColor(priority == .medium ? Color("AccentColor") : Color(red: 0.901, green: 0.901, blue: 0.91, opacity: 1.0))
                                            
                                            Image(systemName: "nosign")
                                                .resizable()
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
                                                .foregroundColor(priority == .high ? Color("AccentColor") : Color(red: 0.901, green: 0.901, blue: 0.91, opacity: 1.0))
                                            
                                            Image(systemName: "nosign")
                                                .resizable()
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
                        if dateToggled {
                            DatePicker(
                                "",
                                selection: $date,
                                displayedComponents: [.date]
                            )
                        }
                    }
                }.listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    Button("Done", action: {
                showEditTaskView.toggle()
                let newTask = TaskInfo(id: UUID(),subject: selectedSubject, name: taskName, taskEmoji: taskEmoji, priority: priority, completed: completed, date: (dateToggled ? date : nil))
                dataManager.tasks.append(newTask)
                dataManager.saveDataToJson()
            })
            )
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
        EditTaskView(showEditTaskView: .constant(true))
    }
}
