//
//  TrackerView.swift
//  SpacePod15
//
//  Created by Mattia Fochesato on 15/11/21.
//

import SwiftUI

struct TrackerView: View {
    @State var buttonTap = false
    var body: some View {
        NavigationView {
            VStack{
            Text("Hurray!")
            Text("You don’t have any task.")
            
        }.navigationTitle("Tracker")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {
                            buttonTap.toggle()
                        }, label: {
                            Image(systemName: "plus.circle.fill" )
                        }
                               )
                    }
                }
            
        }
    }
}

struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerView()
    }
}
