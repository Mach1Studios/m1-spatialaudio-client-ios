import AVFoundation
import Mach1SpatialAPI
import CoreMotion

public class Mach1PlayerImpl: Mach1Player {
    private let mach1Decode = Mach1Decode()
    private let range: ClosedRange = 0...7
    private var players: [AVAudioPlayer] = []
    private var referenceAttitude: CMAttitude? = nil
    
    public init(_ urls: [URL]) {
        do {
            try self.range.forEach {
                players.append(try AVAudioPlayer(contentsOf: urls[$0]))
                players.append(try AVAudioPlayer(contentsOf: urls[$0]))
                players[$0 * 2].numberOfLoops = 10
                players[$0 * 2 + 1].numberOfLoops = 10
                players[$0 * 2].pan = -1.0
                players[$0 * 2 + 1].pan = 1.0
                players[$0 * 2].prepareToPlay()
                players[$0 * 2 + 1].prepareToPlay()
            }
            mach1Decode.setPlatformType(type: Mach1PlatformiOS)
            mach1Decode.setDecodeAlgoType(newAlgorithmType: Mach1DecodeAlgoSpatial)
            mach1Decode.setFilterSpeed(filterSpeed: 1.0)
        } catch {
            print("Error constructing AVAudioPlayers: \(error)")
        }
    }
    
    public func play() {
        // TODO on switch 
        let startTime = players[0].deviceCurrentTime + 1.0
        players.forEach { $0.play(atTime: startTime) }
    }
    
    public func stop() {
        self.referenceAttitude = nil
        players.forEach { $0.stop() }
        range.forEach {
            players[$0 * 2].prepareToPlay()
            players[$0 * 2 + 1].prepareToPlay()
        }
    }
    
    public func onMotionManagerChanged(_ attitude: CMAttitude) {
        // https://developer.apple.com/documentation/coremotion/getting_processed_device-motion_data/understanding_reference_frames_and_device_attitude
        if referenceAttitude == nil { self.referenceAttitude = attitude }
        guard let referenceAttitude = self.referenceAttitude else { return }
        
        let currentAttitude = attitude
        currentAttitude.multiply(byInverseOf: referenceAttitude)
        var deviceYaw = currentAttitude.yaw * 180 / .pi
        var devicePitch = currentAttitude.pitch * 180 / .pi
        var deviceRoll = currentAttitude.roll * 180 / .pi
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, windowScene.activationState == .foregroundActive, let _ = windowScene.windows.first {
            print("Window scene interface orientation \(windowScene.interfaceOrientation)")
            switch windowScene.interfaceOrientation {
            case .unknown:
                print("Window Scene interface orientation UNKNOWN")
                break
            case .portrait:
                deviceYaw += 90
                devicePitch -= 90
                break
            case .portraitUpsideDown:
                deviceYaw -= 90
                devicePitch += 90
                break
            case .landscapeLeft:
                deviceRoll += 90
                break
            case .landscapeRight:
                deviceYaw += 180
                deviceRoll -= 90
                break
            @unknown default:
                print("Window Scene interface orientation DEFAULT unknown")
            }
        } else {
            print("Window scene is nil")
        }
        
        print("RESULT YAW \(deviceYaw)")
        print("RESULT PITCH \(devicePitch)")
        print("RESULT ROLL \(deviceRoll)")
        
        mach1Decode.beginBuffer()
        let decodeArray: [Float]  = mach1Decode.decode(Yaw: Float(deviceYaw), Pitch: Float(devicePitch), Roll: Float(deviceRoll))
        mach1Decode.endBuffer()
        for i in range {
            players[i * 2].setVolume(Float(decodeArray[i * 2]), fadeDuration: 0)
            players[i * 2 + 1].setVolume(Float(decodeArray[i * 2 + 1]), fadeDuration: 0)
        }
    }
}
