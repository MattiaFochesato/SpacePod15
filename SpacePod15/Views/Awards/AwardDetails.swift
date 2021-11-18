//
//  AwardDetails.swift
//  SpacePod15
//
//  Created by Roberto La Croce on 15/11/21.
//

import SwiftUI

struct AwardDetails: View {
    var award: Award
    @Binding var showAwardDetailsView : Bool
    
    var body: some View {
        NavigationView{
            VStack{
                Text(award.name)
                    .font(.title)
                    .bold()
                Spacer()
                Image(award.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight:400)
                
                Spacer()
                Text(award.description)
                Spacer()
                Text("08/03/2020 TODO")
                    .foregroundColor(.gray)
                Spacer()
            }
            .navigationTitle("Your Award")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    Button("Close", action: {
                showAwardDetailsView.toggle()
            }))
        }
    }
}

struct AwardDetails_Previews: PreviewProvider {
    @State static var showAwardDetailsView = false
    static var previews: some View {
        Group {
          AwardDetails(award:
                            Award(name: "Demo Award", description: "Award super long description", imageName: "testAward"),
                         showAwardDetailsView: $showAwardDetailsView
            )
        }
    }
}
