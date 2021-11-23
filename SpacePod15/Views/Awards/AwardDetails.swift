//
//  AwardDetails.swift
//  SpacePod15
//
//  Created by Roberto La Croce on 15/11/21.
//

import SwiftUI
import SceneKit

struct AwardDetails: View {
    var award: Award
    var unlockDate: Date?
    var isJustUnlocked: Bool = false
    
    @Binding var showAwardDetailsView : Bool
    
    
    @State var rotationAngle: Angle = .degrees(0)
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
                /*Image(award.imageName)
                 .resizable()
                 .scaledToFit()
                 .frame(maxHeight:400)*/
                /*SceneView(scene:
                 SCNScene(named: "medal.vox.obj"),
                 options: [.autoenablesDefaultLighting, .allowsCameraControl]
                 ).frame(maxHeight:400)*/
                SceneKitView(radius: 0.02, height: 2, angle: $rotationAngle)
                    .frame(maxHeight:400)
                    .onAppear {
                        self.rotationAngle += .degrees(10000)
                    }
                
                
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

struct SceneKitView: UIViewRepresentable {
    
    @Binding var angle: Angle
    
    let node: SCNNode
    let scene: SCNScene
    
    init(radius: CGFloat, height: CGFloat, angle: Binding<Angle>) {
        
        self.scene = SCNScene(named: "medal.vox.obj")!
        self.scene.background.contents = UIColor.clear
        self.node = self.scene.rootNode
        
        self._angle = angle
        
    }
    
    //SCNScene
    
    func makeUIView(context: UIViewRepresentableContext<SceneKitView>) -> SCNView {
        
        let sceneView = SCNView()
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = false
        return sceneView
    }
    
    func updateUIView(_ sceneView: SCNView, context: UIViewRepresentableContext<SceneKitView>) {
        
        //Rotation animation
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.isRemovedOnCompletion = false
        rotation.duration = 90
        node.addAnimation(rotation, forKey: "rotation")
        node.rotation = SCNVector4(0, 1, 0, angle.radians)
        
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
