import AVFoundation
import Mach1SpatialAPI
import CoreMotion

public class Mach1PlayerImpl: Mach1Player {
    private let mach1Decode = Mach1Decode()
    private var needUpdateReferenceAttitude = true
    private var needUpdateReferenceAttitudeForHeadphones = true
    private var referenceAttitude: CMAttitude? = nil
    
    private var numberOfChannels: Int = 8
    /// SpatialMixer class is a consolidated multichannel->stereo buffer mixer that includes Mach1Decode's coeffs for spatial playback based on orientation
    private var spatialMixer: SpatialMixer
    private var player: AVPlayer
    
    public init(_ url: URL) {
        // initialize for 8 channel input
        // TODO: Replace with initialization based on `mach1Decode.setDecodeAlgoType(newAlgorithmType: Mach1DecodeAlgoSpatial)` channel count
        self.spatialMixer = SpatialMixer(8)
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        var callbacks = spatialMixer.callbacks()
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
    
    public func onMotionManagerChanged(_ sourceType: OrientationSourceType, _ deviceReferenceAttitude: CMAttitude?, _ attitude: CMAttitude) {
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
        mach1Decode.setRotationDegrees(newRotationDegrees: RotationDegreeFactory.construct(currentAttitude, sourceType))
        mach1Decode.beginBuffer()
        let decodeArray: [Float] = mach1Decode.decodeCoeffs()
        mach1Decode.endBuffer()
        spatialMixer.spatialMixerCoeffs = NSMutableArray(array: decodeArray)
    }
    
    func providePlayer() -> AVPlayer {
        return self.player
    }
}
