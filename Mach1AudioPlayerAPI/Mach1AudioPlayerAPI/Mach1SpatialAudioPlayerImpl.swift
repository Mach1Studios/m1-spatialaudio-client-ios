import SwiftUI
import CoreMotion
import SceneKit
import Mach1SpatialAPI

public class Mach1SpatialAudioPlayerImpl: Mach1SpatialAudioPlayer {
    private var play: Bool = false
    private var mach1Decode = Mach1Decode()
    private let sceneService: SceneService
    private let audioPlayer: AudioPlayerService
    private var motionManager = CMMotionManager()
    private var headPhoneMotionManager = CMHeadphoneMotionManager()
    
    public init(_ scene: SCNScene, urls: [URL]) {
        sceneService = SceneService(scene)
        audioPlayer = AudioPlayerService(mach1Decode, urls)
    }
    
    public func view(_ sceneFrame: CGSize) -> some View {
        return sceneService.getView(sceneFrame)
    }
    
    public func playPause(_ orientationSourceType: OrientationSourceType) {
        if (!motionManager.isDeviceMotionAvailable) {
            print("Device motion manager is not available")
            return
        }
        play = !play
        if (play) {
            audioPlayer.play()
            self.initDeviceMotionUpdates(orientationSourceType)
        }
        else {
            audioPlayer.stop()
            motionManager.stopDeviceMotionUpdates()
        }
    }
    
    private func initDeviceMotionUpdates(_ orientationSourceType: OrientationSourceType) {
        switch orientationSourceType {
        case .Device:
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: { (deviceMotion, error) -> Void in
                if let deviceMotion = deviceMotion {
                    self.audioPlayer.onMotionManagerChanged(deviceMotion)
                    self.sceneService.onMotionManagerChanged(deviceMotion)
                } else if let error = error {
                    print("Error when detect device motion updates: \(error)")
                }
            })
            break
        case .Headphones:
            headPhoneMotionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: { (deviceMotion, error) -> Void in
                if let deviceMotion = deviceMotion {
                    self.audioPlayer.onMotionManagerChanged(deviceMotion)
                    self.sceneService.onMotionManagerChanged(deviceMotion)
                } else if let error = error {
                    print("Error when detect device motion updates: \(error)")
                }
            })
            break
        }
    }
}
