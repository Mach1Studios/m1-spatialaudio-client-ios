import CoreMotion

class Mach1MotionManagerStrategy {
    private static var mach1DeviceMotion: Mach1DeviceMotion? = nil
    private static var mach1HeadphonesMotion: Mach1HeadponesMotion? = nil
    
    static func apply(_ orientationSourceType: OrientationSourceType) -> Mach1MotionManger {
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
}

fileprivate class Mach1DeviceMotion: CMMotionManager, Mach1MotionManger {
    private var isRunning = false
    
    func checkAvailability() throws {
        if !self.isDeviceMotionAvailable { throw Mach1AvailabilityMotionError.error("Device motion is not available") }
    }
    
    func start(update: @escaping (CMDeviceMotion) -> Void) {
        startDeviceMotionUpdates(to: OperationQueue.main) { deviceMotion, error in
            guard let deviceMotion = deviceMotion else {
                print("Error device motion: \(String(describing: error))")
                return
            }
            self.isRunning = true
            update(deviceMotion)
        }
    }
    
    func stop() {
        self.isRunning = false
        self.stopDeviceMotionUpdates()
    }
    
    func isActive() -> Bool {
        return self.isRunning
    }
}

fileprivate class Mach1HeadponesMotion: CMHeadphoneMotionManager, Mach1MotionManger {
    private var isRunning = false
    func checkAvailability() throws {
        if !self.isDeviceMotionAvailable { throw Mach1AvailabilityMotionError.error("Device motion is not available") }
    }
    
    func start(update: @escaping (CMDeviceMotion) -> Void) {
        startDeviceMotionUpdates(to: OperationQueue.main) { deviceMotion, error in
            guard let deviceMotion = deviceMotion else {
                print("Error device motion: \(String(describing: error))")
                return
            }
            self.isRunning = true
            update(deviceMotion)
        }
    }
    
    func stop() {
        self.isRunning = false
        self.stopDeviceMotionUpdates()
    }
    
    func isActive() -> Bool {
        return self.isRunning
    }
}
