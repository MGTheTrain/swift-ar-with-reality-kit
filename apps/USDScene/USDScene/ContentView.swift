//
//  ContentView.swift
//  USDScene
//
//  Created by Marvin Gajek on 10.06.24.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Configure the AR session
        let config = ARWorldTrackingConfiguration()
        arView.session.run(config)
        
        // Load the USD scene
        let sceneURL = Bundle.main.url(forResource: "Cyber_Samurai", withExtension: "usdz")!
        let entity = try! Entity.load(contentsOf: sceneURL)
        
        // Create an anchor entity and add the entity as its child
        let anchorEntity = AnchorEntity()
        anchorEntity.addChild(entity)
        
        // Add the anchor entity to the ARView's scene
        arView.scene.anchors.append(anchorEntity)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
