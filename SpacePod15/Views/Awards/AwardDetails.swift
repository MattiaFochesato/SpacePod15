//
//  AwardDetails.swift
//  SpacePod15
//
//  Created by Roberto La Croce on 15/11/21.
//

import SwiftUI

struct AwardDetails: View {
    var award: Award
    var unlockDate: Date?
    var isJustUnlocked: Bool = false
    
    @Binding var showAwardDetailsView : Bool
    
    var body: some View {
        NavigationView{
            VStack(spacing: 0){
                if isJustUnlocked {
                LinearGradient(gradient: Gradient(colors: [.pink, .blue]),
                               startPoint: .leading,
                               endPoint: .trailing)
                    .mask(Text("Congratulations!")
                            .font(.title)
                            .bold())
                    .frame(height: 40)
                    Spacer()
                }
                Text(award.name)
                    .font(isJustUnlocked ? .title2 : .title)
                    .bold()
                Spacer()
                Image(award.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight:400)
                
                Spacer()
                Text(award.description)
                
                if !isJustUnlocked {
                    Spacer()
                    Text((unlockDate ?? Date()).prettyPrint())
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .navigationTitle(isJustUnlocked ? "New Award Unlocked" : "Your Award")
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
            AwardDetails(award:
                              Award(name: "Demo Award", description: "Award super long description", imageName: "testAward"),
                         isJustUnlocked: true,
                           showAwardDetailsView: $showAwardDetailsView
            ).frame(height: 400)
        }
    }
}
