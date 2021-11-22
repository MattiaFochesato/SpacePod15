//
//  TrackerView.swift
//  SpacePod15
//
//  Created by Mattia Fochesato on 15/11/21.
//

import SwiftUI

struct TrackerView: View {
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.isSearching) var isSearching //
    
    
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
                            VStack(spacing: 0) {
                                ForEach(dataManager.tasks.filter({($0).name.contains(searchText) || searchText.isEmpty}),id:\.self){ task in
                                  NavigationLink {
                                        TappedTask(task: task)
                                    } label: {
                                        TaskRow(task: task)
                                            .cornerRadius(10)
                                            .padding([.leading, .trailing])
                                            .padding([.top, .bottom], 10)
                                            .shadow(radius: 10)
                                    }.buttonStyle(ScaleButtonStyle())
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
            .environmentObject(DataManager())
    }
}
