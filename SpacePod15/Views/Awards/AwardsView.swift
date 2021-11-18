//
//  AwardsView.swift
//  SpacePod15
//
//  Created by Mattia Fochesato on 15/11/21.
//

import SwiftUI

struct SubjectAwards: Hashable {
    var name: String
    var awards: [Award]
}

struct Award: Hashable {
    var imageName: String
}

struct AwardsView: View {
    let subjects: [SubjectAwards] = [
        SubjectAwards(name: "Italiano", awards: []),
        SubjectAwards(name: "Geografia", awards: []),
        SubjectAwards(name: "Boh", awards: []),
        SubjectAwards(name: "Storia", awards: []),
        SubjectAwards(name: "Boh", awards: []),
        SubjectAwards(name: "Storia", awards: [])
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(subjects, id: \.self) { item in
                        AwardRow(subject: item)
                            .padding(.bottom, 16)
                    }
                }
                //.padding([.leading, .trailing], 16)
                .padding(.top, 20)
            }.navigationTitle("Awards")
        }
    }
}

struct AwardRow: View {
    let subject: SubjectAwards
    var body: some View {
        Text(subject.name)
            .font(.title3)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.leading, .trailing], 24)
        
        //ScrollView {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                
                
                ForEach(["testAward", "testAward", "testAward","testAward", "testAward", "testAward"], id: \.self) {
                    award in
                    AwardImageView(award: Award(imageName: award))
                        .padding(.leading, 8)
                    Spacer()
                }.padding(.bottom, 16)
                    .padding(.top, 4)
            }
            
            
            
        }.frame(maxWidth: .infinity)
        //}
        
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
            Image("testAward")
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
                .padding(.trailing, 10)
                .background(Color(red: 0.951, green: 0.951, blue: 0.98, opacity: 1.0))
                .cornerRadius(20)
                .shadow(radius: 5, x: 5, y: 5)
            }.sheet(isPresented: $showAwardDetailsView){
                AwardDetails($showAwardDetailsView: $showAwardDetailsView)
                }
            }
        }
    }

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        //AwardRow(subject:  SubjectAwards(name: "🤌🏻 Italiano", awards: []))
        AwardsView()
    }
}
