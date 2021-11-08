import SwiftUI
import CoreMotion
import SceneKit
import MediaToolbox

public class Mach1SpatialAudioPlayerImpl: Mach1SpatialAudioPlayer {
    private var play: Bool = false
    private let mach1Scene: Mach1Scene
    private let mach1Player: Mach1Player
    private var mach1MotionManger: Mach1MotionManger? = nil
    private var mach1MotionMangerScene: Mach1MotionManger? = nil
    
    required public init(_ scene: SCNScene, url: URL) {
        mach1Scene = Mach1SceneImpl(scene)
        mach1Player = Mach1PlayerImpl(url)
    }
    
    public func view(_ sceneFrame: CGSize) -> some View {
        return mach1Scene.getView(sceneFrame) {
            self.mach1Player.setNeedUpdateAttitudeReference()
            self.mach1Scene.resetSceneReference()
        }
    }
    
    public func playPause() {
        do {
            try mach1MotionManger?.checkAvailability()
        } catch {
            print(error)
            return
        }
        play = !play
        if (play) {
            startListenMotion()
            mach1Player.play()
        }
        else {
            mach1Player.stop()
            mach1MotionManger?.stop()
        }
    }
    
    public func setSourceType(_ orientationSourceType: OrientationSourceType) {
        mach1MotionManger?.stop()
        mach1MotionMangerScene?.stop()
        self.mach1MotionManger = Mach1MotionManagerStrategy.apply(orientationSourceType)
        self.mach1MotionMangerScene = Mach1MotionManagerSceneStrategy.apply(orientationSourceType)
        mach1Scene.sourceTypeChanged()
        mach1MotionMangerScene?.stop()
        self.isTypeChanged = true
        if (play) { startListenMotion() }
    }
    
    public func clear() {
        mach1Scene.sourceTypeChanged()
        mach1Player.stop()
        mach1MotionManger?.stop()
        mach1MotionManger = nil
    }
    
    private var isTypeChanged = true
    private func startListenMotion() {
        mach1MotionManger?.start { deviceMotion in
            self.mach1Player.onMotionManagerChanged(Mach1MotionManagerStrategy.orientationSourceType, Mach1MotionManagerStrategy.getMotionManager(), deviceMotion.attitude)
            if (self.isTypeChanged) {
                self.mach1Player.setNeedUpdateAttitudeReference()
                self.isTypeChanged = false
            }
        }
        mach1MotionMangerScene?.start { deviceMotion in
            self.mach1Scene.onMotionManagerChanged(deviceMotion.attitude)
        }
    }
}
