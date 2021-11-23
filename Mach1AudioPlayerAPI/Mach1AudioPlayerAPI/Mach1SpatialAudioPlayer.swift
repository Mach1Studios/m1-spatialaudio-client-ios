import SwiftUI
import SceneKit
import AVFAudio

public protocol Mach1SpatialAudioPlayer {
    init(_ scene: SCNScene, url: URL)
    func observe(_ orientationSourceChange: OrientationSourceChange)
    associatedtype V: View
    func view(_ sceneFrame: CGSize) -> V
    func playPause()
    func setSourceType(_ orientationSourceType: OrientationSourceType)
    func clear()
    func player() -> AVPlayer
}
