//
//  TrackerView.swift
//  SpacePod15
//
//  Created by Mattia Fochesato on 15/11/21.
//

import SwiftUI

struct TrackerView: View {
    @EnvironmentObject var dataManager: DataManager
    
    
    @State var searchText: String = ""
    @State var mode: String = "Light"
    var body: some View {
        NavigationView {
            //ScrollView {
            VStack {
                Picker("Color", selection: $mode) {
                    Text("Light").tag(0)
                    Text("Dark").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding([.leading, .trailing], 8)
                
                VStack {
                    if dataManager.tasks.count == 0 {
                        VStack{
                            Image("testAward")
                            Text("Hurray!")
                            Text("You don’t have any task.")
                        }
                    }else{
                        ScrollView {
                            VStack {
                                ForEach(dataManager.tasks, id: \.self) { task in
                                    Text(task.name)
                                    Divider()
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Tracker")
            .searchable(text: $searchText)
            /*.toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("Color", selection: $mode) {
                        Text("Light").tag(0)
                        Text("Dark").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }*/
        }
    }
}

struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerView()
    }
}
