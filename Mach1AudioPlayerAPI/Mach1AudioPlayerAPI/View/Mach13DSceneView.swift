import SwiftUI
import SceneKit

public struct Mach13DSceneView: View {
    let scene: SCNScene
    let sceneFrame: CGSize
    
    public var body: some View {
        SceneView(
            scene: scene,
            options: [.autoenablesDefaultLighting]
        ).frame(width: sceneFrame.width, height: sceneFrame.height)
    }
}
