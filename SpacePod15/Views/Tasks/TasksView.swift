//
//  ContentView.swift
//  SpacePod15
//
//  Created by Mattia Fochesato on 15/11/21.
//

import SwiftUI
import ExyteGrid

struct TasksView: View {
    @EnvironmentObject var dataManager: DataManager
    
    @State var showEditTaskView = false
    @State var showNewAwardView = false
    @State var newAward: Award! = Award(name: "test", description: "test", imageName: "")
    
    var columns: [GridItem] = [
        
        GridItem(.fixed(200)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
        
    ]
    
    var body: some View {
        
        NavigationView {
            VStack {
                let tasksToShow = dataManager.tasks.filter({ task in
                    if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1"{
                        return task.completed == nil
                    }else{
                        return true
                    }
                })
                if tasksToShow.count == 0 {
                    VStack{
                        //Image("testAward")
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 60).bold())
                            .foregroundColor(Color("AccentColor"))
                        Text("Well done!")
                            .font(.title3)
                            .bold()
                        Text("You don’t have any task to complete.")
                    }
                }else{
                    //ScrollView {
                    /*VStack(spacing: 0) {
                     ForEach(tasksToShow, id: \.self) { task in
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
                     }*/
                    //VStack {
                    Grid(tracks: 3, spacing: 12) {
                        ForEach(tasksToShow, id: \.self) { task in
                            NavigationLink {
                                TappedTask(task: task)
                            } label: {
                                TaskRow(task: task)
                                    .cornerRadius(10)
                                    //.padding([.leading, .trailing])
                                    //.padding([.top, .bottom], 10)
                                    .shadow(radius: 8)
                            }.buttonStyle(ScaleButtonStyle())
                                .gridSpan(column: task.priority.rawValue + 1)
                        }
                    }.gridContentMode(.scroll)
                    //}
                    //}
                }
            }
            .navigationTitle("Tasks")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        showEditTaskView.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill" )
                    }
                    ).sheet(isPresented: $showEditTaskView){
                        EditTaskView(showEditTaskView: $showEditTaskView, taskToEdit: nil)
                    }
                }
            }
            
        }.onChange(of: dataManager.unlockedAwards) { unlockedAwards in
            print("Unlocked awards!")
            let newAward = unlockedAwards.sorted { aw1, aw2 in
                aw1.date > aw2.date
            }.first!
            
            for sub in Subject.subjects {
                for aw in sub.awards {
                    if aw.imageName == newAward.awardName {
                        dataManager.lastUnlockedAward = aw
                        break
                    }
                }
            }
            
            
            self.showNewAwardView = true
        }.sheet(isPresented: $showNewAwardView) {
            HalfSheet {
                AwardDetails(award: dataManager.lastUnlockedAward,
                             isJustUnlocked: true, showAwardDetailsView: $showNewAwardView)
            }
        }
    }
}

struct TaskRow: View {
    var task: TaskInfo
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Image("bgScienze")
                    .resizable()
                    .scaledToFit()
                
                LinearGradient(gradient: Gradient(colors: [.clear, .clear, .black]), startPoint: .top, endPoint: .bottom)
                
                
                VStack(alignment: .leading) {
                    HStack {
                        /*if task.taskEmoji.count == 1 {
                         Text(task.taskEmoji)
                         .foregroundColor(.white)
                         .frame(width: 20, height: 20)
                         .frame(width: 40, height: 40)
                         .background(Color.secondary)
                         .clipShape(Circle())
                         .padding([.leading, .top], 8)
                         }*/
                        if let completedDate = task.completed {
                            Image(systemName:  "checkmark")
                                .resizable()
                                .font(Font.title.weight(.bold))
                                .foregroundColor(.green)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .frame(width: 40, height: 40)
                                .background(Color.secondary)
                                .clipShape(Circle())
                                .padding([.leading, .top], 8)
                            
                            Text(completedDate.prettyPrint())
                                .bold()
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.secondary)
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                                .padding([.top], 8)
                        }
                        
                        Spacer()
                        
                        if (task.completed == nil && task.date != nil && task.date! <= Date()) {
                            Image(systemName: "alarm.fill")
                                .resizable()
                                .font(Font.title.weight(.bold))
                                .foregroundColor(.white)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .frame(width: 40, height: 40)
                                .background(Color.orange)
                                .clipShape(Circle())
                                .padding([.top, .trailing], 8)
                        }
                        
                        
                        if task.completed != nil {
                            Image(systemName:  "exclamationmark\(task.priority != .low ? ".\(task.priority.rawValue+1)" : "")")
                                .resizable()
                                .font(Font.title.weight(.bold))
                                .foregroundColor(.white)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .frame(width: 40, height: 40)
                                .background(Color.secondary)
                                .clipShape(Circle())
                                .padding([.trailing, .top], 8)
                        }
                        
                        
                        
                    }
                    Spacer()
                    Text(task.name)
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading/*, .bottom*/], 8)
                        .shadow(radius: 10)
                    HStack {
                        Text(task.subject)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .bold()
                        
                        Spacer()
                        
                        if let date = task.date {
                            if task.completed == nil {
                                Text(date.prettyPrint())
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                    }.padding([.leading, .trailing], 8)
                        .padding([.bottom], 8)
                    
                }
            }
            
        }.frame(height: 150)
            .frame(maxWidth: .infinity)
        //.background(Image("bgScienze"))
            .background(Color(red: 0.784, green: 0.616, blue: 0.616, opacity: 1.0))
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
            .environmentObject(DataManager().getDemoDataManager())
    }
}
