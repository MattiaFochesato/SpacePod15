//
//  EditTaskView.swift
//  SpacePod15
//
//  Created by Roberto La Croce on 16/11/21.
//

import Foundation
import SwiftUI


struct EditTaskView: View {
    var subjects = ["Italiano", "Matematica", "Latino", "Scienze"]
        @State private var selectedSubject = "Italiano"
    var body: some View {
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
            
                    }
                }
        }
    


struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView()
    }
}
