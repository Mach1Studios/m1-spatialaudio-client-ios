import AVFoundation
import Mach1SpatialAPI
import CoreMotion

public class Mach1PlayerImpl: Mach1Player {
    private let mach1Decode = Mach1Decode()
    private let range: ClosedRange = 0...7
    private var players: [AVAudioPlayer] = []
    private var needUpdateReferenceAttitude = true
    private var needUpdateReferenceAttitudeForHeadphones = true
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
            mach1Decode.setPlatformType(type: Mach1PlatformDefault)
            mach1Decode.setDecodeAlgoType(newAlgorithmType: Mach1DecodeAlgoSpatial)
            mach1Decode.setFilterSpeed(filterSpeed: 0.95)
        } catch {
            print("Error constructing AVAudioPlayers: \(error)")
        }
    }
    
    public func play() {
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
    
    public func setNeedUpdateAttitudeReference() {
        self.referenceAttitude = nil
        needUpdateReferenceAttitude = true
        needUpdateReferenceAttitudeForHeadphones = true
    }
    
    public func onMotionManagerChanged(_ sourceType: OrientationSourceType?, _ deviceReferenceAttitude: CMAttitude?, _ attitude: CMAttitude) {
        guard let sourceType = sourceType else { return }
        switch sourceType {
        case .Device:
            if let referenceAttitude = deviceReferenceAttitude, needUpdateReferenceAttitude {
                self.referenceAttitude = referenceAttitude
                self.needUpdateReferenceAttitude = false
            }
        case .Headphones:
            if needUpdateReferenceAttitudeForHeadphones {
                referenceAttitude = attitude
                needUpdateReferenceAttitudeForHeadphones = false
                return
            }
            break
        }

        // https://developer.apple.com/documentation/coremotion/getting_processed_device-motion_data/understanding_reference_frames_and_device_attitude
        let currentAttitude = attitude
        guard let referenceAttitude = referenceAttitude else { return }
        currentAttitude.multiply(byInverseOf: referenceAttitude)
        let deviceYaw = -currentAttitude.yaw * 180 / .pi
        let devicePitch = currentAttitude.pitch * 180 / .pi
        let deviceRoll = currentAttitude.roll * 180 / .pi
        
        print("RESULT YAW \(deviceYaw)")
        print("RESULT PITCH \(devicePitch)")
        print("RESULT ROLL \(deviceRoll)")
        
        let orientation = Mach1Point3D(x: Float(deviceYaw), y: Float(devicePitch), z: Float(deviceRoll))
        mach1Decode.setRotationDegrees(newRotationDegrees: orientation)
        
        mach1Decode.beginBuffer()
        let decodeArray: [Float]  = mach1Decode.decodeCoeffs()
        mach1Decode.endBuffer()
        for i in range {
            players[i * 2].setVolume(Float(decodeArray[i * 2]), fadeDuration: 0)
            players[i * 2 + 1].setVolume(Float(decodeArray[i * 2 + 1]), fadeDuration: 0)
        }
    }
}
