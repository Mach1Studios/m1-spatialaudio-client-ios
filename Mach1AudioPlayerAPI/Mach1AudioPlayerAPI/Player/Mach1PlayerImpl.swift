import AVFoundation
import Mach1SpatialAPI
import CoreMotion

public class Mach1PlayerImpl: NSObject, Mach1Player {
    private let mach1Decode = Mach1Decode()
    private var needUpdateReferenceAttitude = true
    private var needUpdateReferenceAttitudeForHeadphones = true
    private var referenceAttitude: CMAttitude? = nil
    
    private var numberOfChannels: Int = 8
    /// SpatialMixer class is a consolidated multichannel->stereo buffer mixer that includes Mach1Decode's coeffs for spatial playback based on orientation
    private var spatialMixer: SpatialMixer
    private var player: AVPlayer?
    private let url: URL
    
    public init(_ url: URL) {
        // initialize for 8 channel input
        // TODO: Replace with initialization based on `mach1Decode.setDecodeAlgoType(newAlgorithmType: Mach1DecodeAlgoSpatial)` channel count
        self.spatialMixer = SpatialMixer(8)
        self.url = url
        mach1Decode.setPlatformType(type: Mach1PlatformDefault)
        mach1Decode.setDecodeAlgoType(newAlgorithmType: Mach1DecodeAlgoSpatial)
        mach1Decode.setFilterSpeed(filterSpeed: 0.95)
    }
    
    public func initialize() {
        let asset = AVURLAsset(url: url)
        asset.resourceLoader.setDelegate(self, queue: DispatchQueue.global())
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
    }
    
    public func play() {
        if self.player == nil { self.initialize() }
        guard let player = self.player else { return }
        
        player.play()
    }
    
    public func stop() {
        self.referenceAttitude = nil
        if let player = self.player { player.pause() }
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
        if self.player == nil { self.initialize() }
        
        return player!
    }
}

extension Mach1PlayerImpl : AVAssetResourceLoaderDelegate {
    public func resourceLoader(_ resourceLoader: AVAssetResourceLoader, shouldWaitForLoadingOfRequestedResource loadingRequest: AVAssetResourceLoadingRequest) -> Bool {
        if let url = loadingRequest.request.url {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            components.scheme = "http" // replace with the real URL scheme
            components.path = String(components.path.dropLast(4))

            if let attributes = try? FileManager.default.attributesOfItem(atPath: components.url!.path),
                let fileSize = attributes[FileAttributeKey.size] as? Int64 {
                loadingRequest.contentInformationRequest?.isByteRangeAccessSupported = true
                loadingRequest.contentInformationRequest?.contentType = "audio/wav"
                loadingRequest.contentInformationRequest?.contentLength = fileSize

                let requestedOffset = loadingRequest.dataRequest!.requestedOffset
                let requestedLength = loadingRequest.dataRequest!.requestedLength

                if let handle = try? FileHandle(forReadingFrom: components.url!) {
                    handle.seek(toFileOffset: UInt64(requestedOffset))
                    let data = handle.readData(ofLength: requestedLength)

                    loadingRequest.dataRequest?.respond(with: data)
                    loadingRequest.finishLoading()

                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
