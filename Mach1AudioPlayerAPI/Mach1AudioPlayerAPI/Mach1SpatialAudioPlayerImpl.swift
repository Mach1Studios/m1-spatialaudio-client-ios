import SwiftUI
import CoreMotion
import SceneKit

public class Mach1SpatialAudioPlayerImpl: Mach1SpatialAudioPlayer {
    private var play: Bool = false
    private let mach1Scene: Mach1Scene
    private let mach1Player: Mach1Player
    private var mach1MotionManger: Mach1MotionManger? = nil
    
    public init(_ scene: SCNScene, urls: [URL]) {
        mach1Scene = Mach1SceneImpl(scene)
        mach1Player = Mach1PlayerImpl(urls)
    }
    
    public func view(_ sceneFrame: CGSize) -> some View {
        return mach1Scene.getView(sceneFrame)
    }
    
    public func playPause(_ orientationSourceType: OrientationSourceType) {
        // TODO check if change orientationSourceType this will be triggered
        // and maybe if type is changed then we need to reset at start or not?
        mach1MotionManger = Mach1MotionManagerStrategy.apply(orientationSourceType)
        do {
            try mach1MotionManger?.checkAvailability()
        } catch {
            print(error)
            return
        }
        play = !play
        if (play) {
            mach1Player.play()
            mach1MotionManger?.start { deviceMotion in
                self.mach1Player.onMotionManagerChanged(deviceMotion.attitude)
                self.mach1Scene.onMotionManagerChanged(deviceMotion.attitude)
            }
        }
        else {
            mach1Player.stop()
            mach1MotionManger?.stop()
        }
    }
}
