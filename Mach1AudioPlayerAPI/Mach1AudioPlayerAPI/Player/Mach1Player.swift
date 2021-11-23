import CoreMotion

protocol Mach1Player {
    func play()
    func stop()
    func onMotionManagerChanged(_ sourceType: OrientationSourceType?, _ deviceReferenceAttitude: CMAttitude?, _ attitude: CMAttitude)
    func setNeedUpdateAttitudeReference()
    func providePlayer() -> AVPlayer
}
