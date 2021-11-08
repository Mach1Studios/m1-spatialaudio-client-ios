import SwiftUI
import SceneKit

public protocol Mach1SpatialAudioPlayer {
    init(_ scene: SCNScene, url: URL)
    associatedtype V: View
    func view(_ sceneFrame: CGSize) -> V
    func playPause()
    func setSourceType(_ orientationSourceType: OrientationSourceType)
    func clear()
}
