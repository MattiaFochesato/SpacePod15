//
//  AwardsView.swift
//  SpacePod15
//
//  Created by Mattia Fochesato on 15/11/21.
//

import SwiftUI

struct AwardsView: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(Subject.subjects, id: \.self) { item in
                        if item.awards.count != 0 {
                            AwardRow(subject: item)
                                .padding(.bottom, 8)
                        }
                    }
                }
                //.padding([.leading, .trailing], 16)
                .padding(.top, 20)
            }.navigationTitle("Awards")
        }
    }
}

struct AwardRow: View {
    @EnvironmentObject var dataManager: DataManager
    
    let subject: Subject
    var body: some View {
        Text(subject.name)
            .font(.title3)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.leading, .trailing], 24)
        
        if subject.awards.count != 0 {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 2) {
                    ForEach(subject.awards, id: \.self) {
                        award in
                        let isUnlocked = dataManager.unlockedAwards.filter { unlockedAward in
                            unlockedAward.awardName == award.imageName
                        }.count != 0
                        AwardImageView(award: award, unlocked: isUnlocked)
                            .padding(.leading, 8)
                        Spacer()
                    }.padding(.bottom, 16)
                        .padding(.top, 4)
                }
            }.frame(maxWidth: .infinity)
        }else{
            Text("You have not unlocked any awards for this subject.")
                .padding([.trailing, .leading], 16)
                .foregroundColor(.gray)
        }
        Divider()
        
    }
}



struct AwardImageView: View {
    @State var showAwardDetailsView = false
    let award: Award
    let unlocked: Bool
    
    var body: some View {
        
        VStack {
            Button(action: {
                if unlocked {
                    self.showAwardDetailsView.toggle()
                } else {
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.error)
                }
            }){
                ZStack {
                    Image(award.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .grayscale(unlocked ? 0.0 : 1.0)
                        .blur(radius: unlocked ? 0 : 4)
                        .padding(4)
                        .background(Color(red: 0.951, green: 0.951, blue: 0.98, opacity: 1.0))
                        .cornerRadius(20)
                        .shadow(radius: 5, x: 5, y: 5)
                    if !unlocked {
                        Image(systemName: "lock.fill")
                            .font(.system(size: 40).bold())
                    }
                }
                    
            }.frame(width: 90, height: 90)
                .sheet(isPresented: $showAwardDetailsView){
                    AwardDetails(award: award, showAwardDetailsView: $showAwardDetailsView)
                }
                .buttonStyle(ScaleButtonStyle())
                
        }
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        //AwardImageView(award: Award(name: "", description: "", imageName: "testAward"))
        //AwardRow(subject:  SubjectAwards(name: "🤌🏻 Italiano", awards: []))
        AwardsView()
            .environmentObject(DataManager().getDemoDataManager())
    }
}
