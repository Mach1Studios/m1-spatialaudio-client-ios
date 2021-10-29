import CoreMotion

class Mach1MotionManagerStrategy {
    private static var mach1DeviceMotion: Mach1DeviceMotion? = nil
    private static var mach1HeadphonesMotion: Mach1HeadponesMotion? = nil
    static var orientationSourceType: OrientationSourceType? = nil
    
    static func apply(_ orientationSourceType: OrientationSourceType) -> Mach1MotionManger {
        self.orientationSourceType = orientationSourceType
        switch orientationSourceType {
        case .Device:
            guard let mach1DeviceMotion = self.mach1DeviceMotion else {
                self.mach1DeviceMotion = Mach1DeviceMotion()
                return self.mach1DeviceMotion!
            }
            return mach1DeviceMotion
        case .Headphones:
            guard let mach1HeadphonesMotion = self.mach1HeadphonesMotion else {
                self.mach1HeadphonesMotion = Mach1HeadponesMotion()
                return self.mach1HeadphonesMotion!
            }
            return mach1HeadphonesMotion
        }
    }
    
    static func getMotionManager() -> CMAttitude? {
        guard let orientationSourceType = self.orientationSourceType else { return nil }
        switch orientationSourceType {
        case .Device:
            return mach1DeviceMotion?.deviceMotion?.attitude
        case .Headphones:
            return mach1HeadphonesMotion?.deviceMotion?.attitude
        }
    }
}

class Mach1MotionManagerSceneStrategy {
    private static var mach1DeviceMotion: Mach1DeviceMotion? = nil
    private static var mach1HeadphonesMotion: Mach1HeadponesMotion? = nil
    static var orientationSourceType: OrientationSourceType? = nil
    
    static func apply(_ orientationSourceType: OrientationSourceType) -> Mach1MotionManger {
        self.orientationSourceType = orientationSourceType
        switch orientationSourceType {
        case .Device:
            guard let mach1DeviceMotion = self.mach1DeviceMotion else {
                self.mach1DeviceMotion = Mach1DeviceMotion()
                return self.mach1DeviceMotion!
            }
            return mach1DeviceMotion
        case .Headphones:
            guard let mach1HeadphonesMotion = self.mach1HeadphonesMotion else {
                self.mach1HeadphonesMotion = Mach1HeadponesMotion()
                return self.mach1HeadphonesMotion!
            }
            return mach1HeadphonesMotion
        }
    }
    
    static func getMotionManager() -> CMAttitude? {
        guard let orientationSourceType = self.orientationSourceType else { return nil }
        switch orientationSourceType {
        case .Device:
            return mach1DeviceMotion?.deviceMotion?.attitude
        case .Headphones:
            return mach1HeadphonesMotion?.deviceMotion?.attitude
        }
    }
}

fileprivate class Mach1DeviceMotion: CMMotionManager, Mach1MotionManger {
    func checkAvailability() throws {
        if !self.isDeviceMotionAvailable { throw Mach1AvailabilityMotionError.error("Device motion is not available") }
    }
    
    func start(update: @escaping (CMDeviceMotion) -> Void) {
        startDeviceMotionUpdates(to: OperationQueue.main) { deviceMotion, error in
            guard let deviceMotion = deviceMotion else {
                print("Error device motion: \(String(describing: error))")
                return
            }
            update(deviceMotion)
        }
    }
    
    func stop() {
        self.stopDeviceMotionUpdates()
    }
}

fileprivate class Mach1HeadponesMotion: CMHeadphoneMotionManager, Mach1MotionManger {
    func checkAvailability() throws {
        if !self.isDeviceMotionAvailable { throw Mach1AvailabilityMotionError.error("Device motion is not available") }
    }

    func start(update: @escaping (CMDeviceMotion) -> Void) {
        startDeviceMotionUpdates(to: OperationQueue.main) { deviceMotion, error in
            guard let deviceMotion = deviceMotion else {
                print("Error device motion: \(String(describing: error))")
                return
            }
            update(deviceMotion)
        }
    }

    func stop() {
        self.stopDeviceMotionUpdates()
    }
}
