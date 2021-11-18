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
                        AwardRow(subject: item)
                            .padding(.bottom, 8)
                    }
                }
                //.padding([.leading, .trailing], 16)
                .padding(.top, 20)
            }.navigationTitle("Awards")
        }
    }
}

struct AwardRow: View {
    let subject: Subject
    var body: some View {
        Text(subject.name)
            .font(.title3)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.leading, .trailing], 24)
        
        if subject.awards.count != 0 {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    
                    
                    ForEach(subject.awards, id: \.self) {
                        award in
                        AwardImageView(award: award)
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
    
    var body: some View {
        
        VStack {
            Button(action: {
                self.showAwardDetailsView.toggle()
            }){
                Image(award.imageName)
                    .resizable()
                    .scaledToFit()
                    .padding(4)
                    .background(Color(red: 0.951, green: 0.951, blue: 0.98, opacity: 1.0))
                    .cornerRadius(20)
                    .shadow(radius: 5, x: 5, y: 5)
            }.frame(width: 90, height: 90)
                .sheet(isPresented: $showAwardDetailsView){
                    AwardDetails(award: award, showAwardDetailsView: $showAwardDetailsView)
                }
        }
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        //AwardImageView(award: Award(name: "", description: "", imageName: "testAward"))
        //AwardRow(subject:  SubjectAwards(name: "🤌🏻 Italiano", awards: []))
        AwardsView()
    }
}
