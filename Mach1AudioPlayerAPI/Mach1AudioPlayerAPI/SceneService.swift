import CoreMotion
import SceneKit
import SwiftUI

public class SceneService {
    private var motion: CMDeviceMotion?
    private let scene: SCNScene
    private var needInitialReference: Bool = true
    private var referenceFrame = matrix_identity_float4x4
    
    public init(_ scene: SCNScene) {
        self.scene = scene
    }
    
    public func getView(_ sceneFrame: CGSize) -> some View {
        return Button { self.initSceneReference() }
               label: { Mach13DSceneView(scene: scene, sceneFrame: sceneFrame) }
    }
    
    private func initSceneReference() {
        if let deviceMotion = motion {
            referenceFrame = float4x4(rotationMatrix: deviceMotion.attitude.rotationMatrix).inverse
        }
    }
    
    public func onMotionManagerChanged(_ deviceMotion: CMDeviceMotion) {
        self.motion = deviceMotion
        if self.needInitialReference {
            self.initSceneReference()
            self.needInitialReference = false
        }
        let rotation = float4x4(rotationMatrix: deviceMotion.attitude.rotationMatrix)
        let mirrorTransform = simd_float4x4([
            simd_float4(-1.0, 0.0, 0.0, 0.0),
            simd_float4( 0.0, 1.0, 0.0, 0.0),
            simd_float4( 0.0, 0.0, 1.0, 0.0),
            simd_float4( 0.0, 0.0, 0.0, 1.0)
        ])
        scene.rootNode.childNodes.first?.simdTransform = mirrorTransform * rotation * referenceFrame
    }
    
}
