import CoreMotion

protocol Mach1MotionManger {
    func checkAvailability() throws
    func start(update: @escaping (CMDeviceMotion) -> Void)
    func stop()
}
