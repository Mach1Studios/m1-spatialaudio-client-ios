import Foundation
import CoreMotion
import Mach1SpatialAPI

public class RotationDegreeFactory {
    static func construct(_ attitude: CMAttitude, _ sourceType: OrientationSourceType) -> Mach1Point3D {
        let deviceYaw = -attitude.yaw * 180 / .pi
        let devicePitch = sourceType == .Device ? 0.0 : attitude.pitch * 180 / .pi
        let deviceRoll = sourceType == .Device ? 0.0 : attitude.roll * 180 / .pi
        return Mach1Point3D(x: Float(deviceYaw), y: Float(devicePitch), z: Float(deviceRoll))
    }
}
