import CoreMotion

protocol OnPlayerMotion {
    func onMotionUpdatePlayer(_ motion: CMDeviceMotion)
}

protocol OnSceneMotion {
    func onMotionUpdateScene(_ motion: CMDeviceMotion)
}

protocol Mach1MotionManager {
    func onChange(_ orientationSourceType: OrientationSourceType)
    func getAttitude() -> CMAttitude?
}

class Mach1MotionManagerPlayerImpl: BaseMach1MotionManagerImpl {
    init(_ motionManagerDelegate: CMHeadphoneMotionManagerDelegate, _ onPlayerMotion: OnPlayerMotion, _ onSceneMotion: OnSceneMotion) {
        super.init(onPlayerMotion, onSceneMotion)
        self.mach1HeadphonesMotion.delegate = motionManagerDelegate
    }
}

class Mach1MotionManagerSceneImpl: BaseMach1MotionManagerImpl {
}

class BaseMach1MotionManagerImpl: Mach1MotionManager {
    private var mach1DeviceMotion: CMMotionManager & Mach1CoreMotionManager
    open var mach1HeadphonesMotion: CMHeadphoneMotionManager & Mach1CoreMotionManager
    private var orientationSourceType: OrientationSourceType = .Device
    
    init(_ onPlayerMotion: OnPlayerMotion, _ onSceneMotion: OnSceneMotion) {
        self.mach1DeviceMotion = Mach1DeviceMotion(onPlayerMotion, onSceneMotion)
        self.mach1DeviceMotion.deviceMotionUpdateInterval = 1.0 / 60.0
        self.mach1HeadphonesMotion = Mach1HeadponesMotion(onPlayerMotion, onSceneMotion)
        self.onChange(orientationSourceType)
    }
    
    func onChange(_ orientationSourceType: OrientationSourceType) {
        self.orientationSourceType = orientationSourceType
        self.mach1DeviceMotion.needObserve(self.orientationSourceType == .Device)
        self.mach1HeadphonesMotion.needObserve(self.orientationSourceType == .Headphones)
    }
    
    func getAttitude() -> CMAttitude? {
        switch orientationSourceType {
        case .Device:
            return mach1DeviceMotion.deviceMotion?.attitude
        case .Headphones:
            return mach1HeadphonesMotion.deviceMotion?.attitude
        }
    }
}

protocol Mach1CoreMotionManager {
    init(_ onPlayerMotion: OnPlayerMotion, _ onSceneMotion: OnSceneMotion)
    func needObserve(_ isOn: Bool)
}

fileprivate class Mach1DeviceMotion: CMMotionManager, Mach1CoreMotionManager {
    private var isOn = false
    required init(_ onPlayerMotion: OnPlayerMotion, _ onSceneMotion: OnSceneMotion) {
        super.init()
        if (!self.isDeviceMotionAvailable) { return }
        startDeviceMotionUpdates(to: OperationQueue.main) { deviceMotion, error in
            guard let deviceMotion = deviceMotion else {
                print("Error device motion: \(String(describing: error))")
                return
            }
            if (!self.isOn) { return }
            onPlayerMotion.onMotionUpdatePlayer(deviceMotion)
            onSceneMotion.onMotionUpdateScene(deviceMotion)
        }
    }
    func needObserve(_ isOn: Bool) {
        self.isOn = isOn
    }
}

fileprivate class Mach1HeadponesMotion: CMHeadphoneMotionManager, Mach1CoreMotionManager {
    private var isOn = false
    required init(_ onPlayerMotion: OnPlayerMotion, _ onSceneMotion: OnSceneMotion) {
        super.init()
        if (!self.isDeviceMotionAvailable) { return }
        startDeviceMotionUpdates(to: OperationQueue.main) { deviceMotion, error in
            guard let deviceMotion = deviceMotion else {
                print("Error device motion: \(String(describing: error))")
                return
            }
            if (!self.isOn) { return }
            onPlayerMotion.onMotionUpdatePlayer(deviceMotion)
            onSceneMotion.onMotionUpdateScene(deviceMotion)
        }
    }
    
    func needObserve(_ isOn: Bool) {
        self.isOn = isOn
    }
}
