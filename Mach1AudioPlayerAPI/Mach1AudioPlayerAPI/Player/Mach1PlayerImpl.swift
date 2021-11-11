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
    var syncClock: CMClock? = nil
    
    public init(_ url: URL) {
        CMAudioClockCreate(allocator: kCFAllocatorDefault, clockOut: &syncClock)
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
                   
        let avPlayer = AVPlayer(playerItem: playerItem)
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        avPlayer.masterClock = syncClock!
        return avPlayer
    }
    
    public func play() {
        players.forEach { player in
            player.preroll(atRate: 1.0) { prerolled in
                self.onPrerolled()
            }
        }
        logPlayersLatency()
    }
    
    func onPrerolled() {
        prerollCount += 1
        if (prerollCount == 8) {
            players.forEach {
                $0.setRate(1.0, time: CMTime.invalid, atHostTime: CMClockGetTime(syncClock!))
            }
            players.forEach {
                $0.play()
            }
        }
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
    
    private func logPlayersLatency() {
        let interval: CMTime = CMTimeMakeWithSeconds(1, preferredTimescale: 1)
        players[7].addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { time in
            if self.players[7].currentItem?.status == .readyToPlay {
                let lastPlayerTime = CMTimeGetSeconds(self.players[7].currentTime())
                let firstPlayerTime = CMTimeGetSeconds(self.players[0].currentTime())
                let difference = lastPlayerTime - firstPlayerTime
                let forPrint = "DIFF: \(difference) | FIRST | \(firstPlayerTime) | SECOND: \(lastPlayerTime)"
                print(forPrint)
            }
        }
    }
}
