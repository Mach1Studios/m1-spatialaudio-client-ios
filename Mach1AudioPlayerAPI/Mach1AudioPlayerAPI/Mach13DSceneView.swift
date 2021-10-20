import SwiftUI
import SceneKit

struct Mach13DSceneView: View {
    let scene: SCNScene
    let sceneFrame: CGSize
    
    var body: some View {
        SceneView(
            scene: scene,
            options: [.autoenablesDefaultLighting]
        ).frame(width: sceneFrame.width, height: sceneFrame.height)
    }
}
