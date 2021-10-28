import CoreMotion
import UIKit
import SwiftUI

public protocol Mach1Scene {
    func getView(_ sceneFrame: CGSize) -> Button<Mach13DSceneView>
    func onMotionManagerChanged(_ attitude: CMAttitude)
    func sourceTypeChanged()
}
