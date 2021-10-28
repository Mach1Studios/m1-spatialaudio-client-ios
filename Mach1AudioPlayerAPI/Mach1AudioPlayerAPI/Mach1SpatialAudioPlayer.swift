import SwiftUI

public protocol Mach1SpatialAudioPlayer {
    associatedtype V: View
    func view(_ sceneFrame: CGSize) -> V
    func playPause()
    func setSourceType(_ orientationSourceType: OrientationSourceType)
    func clear()
}
