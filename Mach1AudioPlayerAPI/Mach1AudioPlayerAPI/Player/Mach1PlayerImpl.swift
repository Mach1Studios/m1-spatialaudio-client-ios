import AVFoundation
import Mach1SpatialAPI
import CoreMotion

public class Mach1PlayerImpl: Mach1Player {
    private let mach1Decode = Mach1Decode()
    private var needUpdateReferenceAttitude = true
    private var needUpdateReferenceAttitudeForHeadphones = true
    private var referenceAttitude: CMAttitude? = nil
    
    private var numberOfChannels: Int = 8
    private var audioTaps: [AudioTap] = []
    private var players: [AVPlayer] = []
    private var prerollCount = 0
    private var prerollRate = 0
    
    public init(_ url: URL) {
        (0..<numberOfChannels).forEach {
            let audioTap = AudioTap(Int32($0), numberOfChannels: Int32(self.numberOfChannels))!
            audioTaps.append(audioTap)
            players.append(self.setupPlayer(with: url, audioTap: audioTap))
        }
        mach1Decode.setPlatformType(type: Mach1PlatformDefault)
        mach1Decode.setDecodeAlgoType(newAlgorithmType: Mach1DecodeAlgoSpatial)
        mach1Decode.setFilterSpeed(filterSpeed: 0.95)
    }
    
    private func setupPlayer(with url: URL, audioTap: AudioTap) -> AVPlayer {
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        
        var callbacks = audioTap.callbacks()
        
        var tap: Unmanaged<MTAudioProcessingTap>?
        MTAudioProcessingTapCreate(kCFAllocatorDefault, &callbacks, kMTAudioProcessingTapCreationFlag_PreEffects, &tap)
        
        let track = asset.tracks[0]
        let params = AVMutableAudioMixInputParameters(track: track)
        params.audioTapProcessor = tap?.takeUnretainedValue()
        
        let audioMix = AVMutableAudioMix()
        audioMix.inputParameters = [params]
        playerItem.audioMix = audioMix
                   
        let a = AVPlayer(playerItem: playerItem)
        a.automaticallyWaitsToMinimizeStalling = false
        return a
    }
    
    public func play() {
        players.forEach { $0.play() }

    }
    
    public func stop() {
        self.referenceAttitude = nil
        players.forEach { $0.pause() }
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
        let currentAttitude = attitude
        guard let referenceAttitude = referenceAttitude else { return }
        currentAttitude.multiply(byInverseOf: referenceAttitude)
        let deviceYaw = -currentAttitude.yaw * 180 / .pi
        let devicePitch = currentAttitude.pitch * 180 / .pi
        let deviceRoll = currentAttitude.roll * 180 / .pi
        let orientation = Mach1Point3D(x: Float(deviceYaw), y: Float(devicePitch), z: Float(deviceRoll))
        mach1Decode.setRotationDegrees(newRotationDegrees: orientation)
        mach1Decode.beginBuffer()
        let decodeArray: [Float]  = mach1Decode.decodeCoeffs()
        mach1Decode.endBuffer()
        (0..<numberOfChannels).forEach {
            audioTaps[$0].leftVolume = decodeArray[$0 * 2]
            audioTaps[$0].rightVolume = decodeArray[$0 * 2 + 1]
        }
    }
}
