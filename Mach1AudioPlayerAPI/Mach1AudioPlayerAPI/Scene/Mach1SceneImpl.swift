import CoreMotion
import SceneKit
import SwiftUI

public class Mach1SceneImpl: Mach1Scene {
    private var attitude: CMAttitude?
    private let scene: SCNScene
    private var isFirstTime: Bool = true
    private var needInitialReference: Bool = true
    private var referenceFrame = matrix_identity_float4x4
    
    public init(_ scene: SCNScene) {
        self.scene = scene
    }
    
    public func getView(_ sceneFrame: CGSize, _ onSelected: @escaping () -> Void) -> Button<Mach13DSceneView> {
        return Button { onSelected() }
               label: { Mach13DSceneView(scene: scene, sceneFrame: sceneFrame) }
    }
    
    public func sourceTypeChanged() {
        self.attitude = nil
        self.isFirstTime = true
        self.needInitialReference = true
    }
    
    public func resetSceneReference() {
        guard let attitude = self.attitude else { return }
        self.referenceFrame = float4x4(rotationMatrix: attitude.rotationMatrix).inverse
    }
    
    public func onMotionManagerChanged(_ attitude: CMAttitude) {
        let rotation = float4x4(rotationMatrix: attitude.rotationMatrix)
        let mirrorTransform = simd_float4x4([
            simd_float4(-1.0, 0.0, 0.0, 0.0),
            simd_float4( 0.0, 1.0, 0.0, 0.0),
            simd_float4( 0.0, 0.0, 1.0, 0.0),
            simd_float4( 0.0, 0.0, 0.0, 1.0)
        ])
        scene.rootNode.childNodes.first?.simdTransform = mirrorTransform * rotation * referenceFrame
        if isFirstTime {
            isFirstTime = false
            return
        }
        self.attitude = attitude
        if self.needInitialReference {
            self.resetSceneReference()
            self.needInitialReference = false
        }
    }
    
}
