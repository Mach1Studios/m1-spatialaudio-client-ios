import SwiftUI
import SceneKit
import CoreMotion
import AVFoundation
import Mach1SpatialAPI

public class Mach1SpatialAudioPlayerImpl: Mach1SpatialAudioPlayer {
    private var play: Bool = false
    // Scene
    private let scene: SCNScene
    private var needInitialReference: Bool = true
    private var referenceFrame = matrix_identity_float4x4
    // Av player
    private let range: ClosedRange = 0...7
    private var players: [AVAudioPlayer] = []
    // Mach 1
    var m1obj = Mach1Decode()
    // Motion
    lazy var motionManager: CMMotionManager = { return CMMotionManager() }()
    
    public init(_ scene: SCNScene, urls: [URL]) {
        self.scene = scene
        if (urls.count != range.upperBound + 1) {
            print("URL count not equal to \(range.upperBound)")
        } else {
            self.initPlayers(urls)
        }
    }
    
    public func view(_ sceneFrame: CGSize) -> some View {
        return Button { self.initSceneReference() }
               label: { Mach13DSceneView(scene: scene, sceneFrame: sceneFrame) }
    }
    
    public func playPause() {
        if (!motionManager.isDeviceMotionAvailable) {
            print("Device motion manager is not available")
            return
        }
        play = !play
        if (play) {
            players.forEach { $0.play(atTime: players[0].deviceCurrentTime + 1.0) }
            self.initDeviceMotionUpdates()
        }
        else {
            players.forEach { $0.stop() }
            range.forEach {
                players[$0 * 2].prepareToPlay()
                players[$0 * 2 + 1].prepareToPlay()
            }
            motionManager.stopDeviceMotionUpdates()
        }
    }
    
    private func initPlayers(_ urls: [URL]) {
        do {
            for i in range {
                players.append(try AVAudioPlayer(contentsOf: urls[i]))
                players.append(try AVAudioPlayer(contentsOf: urls[i]))
                players[i * 2].numberOfLoops = 10
                players[i * 2 + 1].numberOfLoops = 10
                players[i * 2].pan = -1.0;
                players[i * 2 + 1].pan = 1.0;
                players[i * 2].prepareToPlay()
                players[i * 2 + 1].prepareToPlay()
            }

            m1obj.setPlatformType(type: Mach1PlatformiOS)
            m1obj.setDecodeAlgoType(newAlgorithmType: Mach1DecodeAlgoSpatial)
            m1obj.setFilterSpeed(filterSpeed: 1.0)
        } catch { print(error) }
    }
    
    private func initDeviceMotionUpdates() {
        motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: { (deviceMotion, error) -> Void in
            if let deviceMotion = deviceMotion {
                if self.needInitialReference {
                    self.initSceneReference()
                    self.needInitialReference = false
                }
                self.playMusic(deviceMotion)
                self.onMotionManagerChanged(deviceMotion)
            } else if let error = error {
                print("Error when detect device motion updates: \(error)")
            }
        })
    }
    
    private func initSceneReference() {
        if let deviceMotion = motionManager.deviceMotion {
            referenceFrame = float4x4(rotationMatrix: deviceMotion.attitude.rotationMatrix).inverse
        }
    }
    
    private func playMusic(_ deviceMotion: CMDeviceMotion) {
        let attitude = deviceMotion.attitude
        var deviceYaw = attitude.yaw * 180/Double.pi
        var devicePitch = attitude.pitch * 180/Double.pi
        var deviceRoll = attitude.roll * 180/Double.pi
        switch UIDevice.current.orientation{
            case .portrait:
                deviceYaw += 90
                devicePitch -= 90
            case .portraitUpsideDown:
                deviceYaw -= 90
                devicePitch += 90
            case .landscapeLeft:
                deviceRoll += 90
            case .landscapeRight:
                deviceYaw += 180
                deviceRoll -= 90
            default: break
        }
        m1obj.beginBuffer()
        let decodeArray: [Float]  = m1obj.decode(Yaw: Float(deviceYaw), Pitch: Float(devicePitch), Roll: Float(deviceRoll))
        m1obj.endBuffer()
        for i in range {
            players[i * 2].setVolume(Float(decodeArray[i * 2]), fadeDuration: 0)
            players[i * 2 + 1].setVolume(Float(decodeArray[i * 2 + 1]), fadeDuration: 0)
        }
    }
    
    private func onMotionManagerChanged(_ deviceMotion: CMDeviceMotion) {
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
