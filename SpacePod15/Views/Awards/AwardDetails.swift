//
//  AwardDetails.swift
//  SpacePod15
//
//  Created by Roberto La Croce on 15/11/21.
//

import SwiftUI

struct AwardDetails: View {
    @Binding var showAwardDetailsView : Bool
    
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
            .navigationBarItems(trailing:
                Button("Done", action: {
                showAwardDetailsView.toggle()
            }))
        }
    }
}

struct AwardDetails_Previews: PreviewProvider {
    @State static var showAwardDetailsView = false
    static var previews: some View {
        Group {
            AwardDetails(showAwardDetailsView: $showAwardDetailsView)
        }
    }
}
