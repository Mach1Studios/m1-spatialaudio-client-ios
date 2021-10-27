import CoreMotion

protocol Mach1Player {
    func play()
    func stop()
    func onMotionManagerChanged(_ attitude: CMAttitude)
}
