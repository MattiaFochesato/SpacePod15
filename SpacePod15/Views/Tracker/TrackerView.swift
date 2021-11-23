//
//  TrackerView.swift
//  SpacePod15
//
//  Created by Mattia Fochesato on 15/11/21.
//

import SwiftUI

struct TrackerView: View {
    @EnvironmentObject var dataManager: DataManager
    
    @State var orderMode: Int = SortingFilter.byDate.rawValue
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                let dataToShow = filterData()
                if dataToShow.count != 0 {
                    /*Picker("Order By", selection: $orderMode) {
                        Text("Date").tag(SortingFilter.byDate.rawValue)
                        Text("Subject").tag(SortingFilter.bySubject.rawValue)
                        //Text("Priority").tag(SortingFilter.byPriority.rawValue)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding([.leading, .trailing], 8)*/
                    SearchingFilter(mode: $orderMode)
                }
                    
                VStack {
                    if dataToShow.count == 0 {
                        VStack{
                            //Image("testAward")
                            Image(systemName: "book.closed.fill")
                                .font(.system(size: 60).bold())
                                .foregroundColor(Color("AccentColor"))
                            Text("Much empty")
                                .font(.title3)
                                .bold()
                            Text("Complete a task to move it here!")
                        }
                    }else{
                        ScrollView {
                            VStack(spacing: 0) {
                                
                                
                              ForEach(dataToShow,id:\.self){ task in
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
            .navigationTitle("Journal")
            .searchable(text: $searchText)
        }
    }
    
    func filterData() -> [TaskInfo] {
        var tasksToShow = dataManager.tasks.filter({ $0.completed != nil && (($0).name.contains(searchText) || searchText.isEmpty)})

        
        switch orderMode {
        case SortingFilter.byDate.rawValue:
            tasksToShow = tasksToShow.sorted(by: { t1, t2 in
                t1.date ?? Date() < t2.date ?? Date()
            })
        case SortingFilter.bySubject.rawValue:
            tasksToShow = tasksToShow.sorted(by: { t1, t2 in
                t1.subject < t2.subject
            })
        case SortingFilter.byPriority.rawValue:
            tasksToShow = tasksToShow.sorted(by: { t1, t2 in
                t1.priority.rawValue > t2.priority.rawValue
            })
        default:
            break
            
            
        }
        return tasksToShow
    }
}

struct SearchingFilter: View {
    @Binding var mode: Int
    
    @Environment(\.isSearching) var isSearching
    
    var body: some View {
        VStack {
            if isSearching {
                Picker("Order By", selection: $mode) {
                    Text("Date").tag(SortingFilter.byDate.rawValue)
                    Text("Subject").tag(SortingFilter.bySubject.rawValue)
                    //Text("Priority").tag(SortingFilter.byPriority.rawValue)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding([.leading, .trailing], 8)
            }else{
                EmptyView().frame(width: 0, height: 0)
            }
        }
        
    }
}

enum SortingFilter: Int {
    case byDate = 0
    case bySubject = 1
    case byPriority = 2
}

struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerView()
            .environmentObject(DataManager().getDemoDataManager())
    }
}
