//
//  ContentView.swift
//  SpacePod15
//
//  Created by Mattia Fochesato on 15/11/21.
//

import SwiftUI

struct TasksView: View {
    @State var buttonTap = false
    var body: some View {
        NavigationView {
            VStack{
            Text("Hurray!")
            Text("You don’t have any task.")
        }.navigationTitle("Tasks")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {
                            buttonTap.toggle()
                        }, label: {
                            Image(systemName: "plus.circle.fill" )
                        }
                               ).sheet(isPresented: $buttonTap){
                            infoButton()
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
