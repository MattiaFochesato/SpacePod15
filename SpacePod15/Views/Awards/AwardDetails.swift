//
//  AwardDetails.swift
//  SpacePod15
//
//  Created by Roberto La Croce on 15/11/21.
//

import SwiftUI

struct AwardDetails: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("Newton Award")
                    .font(.title)
                    .bold()
                Spacer()
                Image("testAward")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight:400)
                
                Spacer()
                Text("Premio per aver completato la tua prima task.")
                Spacer()
                Text("08/03/2020")
                Spacer()
            }
            .navigationTitle("Your Award")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AwardDetails_Previews: PreviewProvider {
    static var previews: some View {
        AwardDetails()
    }
}
