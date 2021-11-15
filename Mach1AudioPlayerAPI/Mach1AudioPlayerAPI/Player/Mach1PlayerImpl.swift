import AVFoundation
import Mach1SpatialAPI
import CoreMotion

public class Mach1PlayerImpl: Mach1Player {
    private let mach1Decode = Mach1Decode()
    private var needUpdateReferenceAttitude = true
    private var needUpdateReferenceAttitudeForHeadphones = true
    private var referenceAttitude: CMAttitude? = nil
    
    private var numberOfChannels: Int = 8
    private var audioTap: AudioTap
    private var player: AVPlayer
    
    public init(_ url: URL) {
        self.audioTap = AudioTap(8)
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
        self.player = AVPlayer(playerItem: playerItem)
        mach1Decode.setPlatformType(type: Mach1PlatformDefault)
        mach1Decode.setDecodeAlgoType(newAlgorithmType: Mach1DecodeAlgoSpatial)
        mach1Decode.setFilterSpeed(filterSpeed: 0.95)
    }
    
    public func play() {
        player.play()
    }
    
    public func stop() {
        self.referenceAttitude = nil
        player.pause()
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
        let decodeArray: [Float] = mach1Decode.decodeCoeffs()
        mach1Decode.endBuffer()
        audioTap.volumens = NSMutableArray(array: decodeArray)
    }
}
