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
    
    @State private var name: String = ""
    @State private var taskEmoji: String = ""
    @State private var priority: Int = 0
    @State private var completed: Bool = false
    @State private var date = Date()
    
    @State private var dateToggled = false
    
    var subjects = ["Italiano", "Matematica", "Latino", "Scienze"]
    @State private var selectedSubject = "Italiano"
    
    @State private var text : String = ""
    
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
                        HStack {
                            EmojiTextField(text: $text, placeholder: "..")
                                .frame(maxWidth: 40)
                            
                            TextField("Insert the Task Name", text: $name)
                        }
                    }
                    Section(header: Text("Priority")){
                        HStack{
                            VStack(alignment: .leading){
                                Button {
                                    priority = 0
                                } label: {
                                    Image(systemName: "circle.fill")
                                }
                                .accentColor(/*@START_MENU_TOKEN@*/Color("AccentColor")/*@END_MENU_TOKEN@*/)
                                Text("None")
                                    .padding(.leading, -10.0)
                            }
                            .padding(.leading, 20)
                            .frame(maxWidth: 80)
                            VStack(alignment: .center){
                                Button {
                                    priority = 1
                                } label: {
                                    Image(systemName: "circle.fill")
                                }
                                .accentColor(Color("AccentColor"))
                                Text("Low")
                            }.padding(.leading, -10)
                            .frame(maxWidth: 100)
                            VStack(alignment: .center){
                                Button {
                                    priority = 2
                                } label: {
                                    Image(systemName: "circle.fill")
                                }
                                .accentColor(Color("AccentColor"))
                                Text("Medium")
                            }.padding(.leading, -30).frame(maxWidth: 80)
                            VStack(alignment: .center){
                                Button {
                                    priority = 3
                                } label: {
                                    Image(systemName: "circle.fill")
                                }
                                .accentColor(Color("AccentColor"))
                                Text("High")
                            }.padding(.leading, -30)
                            .frame(maxWidth: 80)
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
                let newTask = TaskInfo(id: UUID(), name: name, taskEmoji: taskEmoji, priority: priority, completed: completed, date: date)
                dataManager.tasks.append(newTask)
            }))
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

struct EmojiContentView: View {
    
    @State private var text: String = ""
    
    var body: some View {
        EmojiTextField(text: $text, placeholder: "Enter emoji")
    }
}




struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(showEditTaskView: .constant(true))
    }
}
