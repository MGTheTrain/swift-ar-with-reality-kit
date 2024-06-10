//
//  ContentView.swift
//  Triangle
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
        config.planeDetection = [.horizontal, .vertical]
        arView.session.run(config)
        
        // Define the vertices and indices for the triangle
        let vertices: [SIMD3<Float>] = [
            SIMD3<Float>(0, 0.1, 0),  // Top vertex
            SIMD3<Float>(-0.1, -0.1, 0),  // Bottom-left vertex
            SIMD3<Float>(0.1, -0.1, 0)  // Bottom-right vertex
        ]
        
        let indices: [UInt32] = [0, 1, 2]
        
        // Create a custom mesh from the vertices and indices
        var meshDescriptor = MeshDescriptor(name: "triangle")
        meshDescriptor.positions = MeshBuffers.Positions(vertices)
        meshDescriptor.primitives = .triangles(indices)
        
        let meshResource = try! MeshResource.generate(from: [meshDescriptor])
        
        // Create a material
        let material = SimpleMaterial(color: .blue, isMetallic: true)
        
        // Create a model entity
        let modelEntity = ModelEntity(mesh: meshResource, materials: [material])
        
        // Create an anchor and add the model entity to it
        let anchor = AnchorEntity(plane: .any)
        anchor.addChild(modelEntity)
        
        // Add the anchor to the scene
        arView.scene.anchors.append(anchor)
        
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
