import SwiftUI
import CoreMotion
import SceneKit

public class Mach1SpatialAudioPlayerImpl: NSObject, Mach1SpatialAudioPlayer, CMHeadphoneMotionManagerDelegate, OnPlayerMotion, OnSceneMotion {
    private var play: Bool = false
    private var isTypeChanged = true
    private let mach1Scene: Mach1Scene
    private let mach1Player: Mach1Player
    private var mach1MotionManagerPlayer: Mach1MotionManagerPlayerImpl? = nil
    private var mach1MotionManagerScene: Mach1MotionManagerSceneImpl? = nil
    private var orientationSourceType: OrientationSourceType = .Device
    private var orientationSourceChange: OrientationSourceChange? = nil
    
    required public init(_ scene: SCNScene, url: URL) {
        mach1Scene = Mach1SceneImpl(scene)
        mach1Player = Mach1PlayerImpl(url)
    }
    
    public func observe(_ orientationSourceChange: OrientationSourceChange) {
        self.orientationSourceChange = orientationSourceChange
        mach1MotionManagerPlayer = Mach1MotionManagerPlayerImpl(self, self, self)
        mach1MotionManagerScene = Mach1MotionManagerSceneImpl(self, self)
    }
    
    public func view(_ sceneFrame: CGSize) -> some View {
        return mach1Scene.getView(sceneFrame) {
            self.mach1Player.setNeedUpdateAttitudeReference()
            self.mach1Scene.resetSceneReference()
        }
    }
    
    public func playPause() {
        play = !play
        if (play) {
            mach1Player.play()
        } else {
            mach1Player.stop()
        }
    }
    
    public func setSourceType(_ orientationSourceType: OrientationSourceType) {
        self.orientationSourceType = orientationSourceType
        self.mach1MotionManagerPlayer?.onChange(orientationSourceType)
        self.mach1MotionManagerScene?.onChange(orientationSourceType)
        mach1Scene.sourceTypeChanged()
        self.isTypeChanged = true
    }
    
    public func clear() {
        mach1Scene.sourceTypeChanged()
        mach1Player.stop()
    }
    
    public func player() -> AVPlayer {
        return mach1Player.providePlayer()
    }
    
    public func headphoneMotionManagerDidConnect(_ manager: CMHeadphoneMotionManager) {
        self.orientationSourceChange?.headphoneMotionConnected()
    }
    
    public func headphoneMotionManagerDidDisconnect(_ manager: CMHeadphoneMotionManager) {
        self.orientationSourceChange?.headphoneMotionDisconnected()
    }
    
    func onMotionUpdatePlayer(_ motion: CMDeviceMotion) {
        self.mach1Player.onMotionManagerChanged(self.orientationSourceType, mach1MotionManagerPlayer?.getAttitude(), motion.attitude)
        if (self.isTypeChanged) {
            self.mach1Player.setNeedUpdateAttitudeReference()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.mach1Scene.resetSceneReference()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.mach1Scene.resetSceneReference()
                }
            }
            self.isTypeChanged = false
        }
    }
    
    func onMotionUpdateScene(_ motion: CMDeviceMotion) {
        self.mach1Scene.onMotionManagerChanged(motion.attitude)
    }

}
