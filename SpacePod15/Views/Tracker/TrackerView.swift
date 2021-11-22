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
    
    var body: some View {
        NavigationView {
            //ScrollView {
            VStack {
                SearchingFilter()
                
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
        }
    }
}

struct SearchingFilter: View {
    @State var mode: Int = 0
    
    @Environment(\.isSearching) var isSearching
    
    var body: some View {
        VStack {
            if isSearching {
                Picker("Filter", selection: $mode) {
                    Text("Light").tag(0)
                    Text("Dark").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding([.leading, .trailing], 8)
            }else{
                EmptyView().frame(width: 0, height: 0)
            }
        }
        
    }
}

struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerView()
            .environmentObject(DataManager().getDemoDataManager())
    }
}
