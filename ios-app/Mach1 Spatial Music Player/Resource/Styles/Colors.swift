import Foundation
import SwiftUI

extension Color {
    static var Mach1Yellow: Color { Color(Colors.Yellow.rawValue) }
    static var Mach1Darkest: Color { Color(Colors.Darkets.rawValue) }
    static var Mach1Dark: Color { Color(Colors.Dark.rawValue) }
    static var Mach1Light: Color { Color(Colors.Light.rawValue) }
    static var Mach1Gray: Color { Color(Colors.Gray.rawValue) }
    static var Mach1GrayLight: Color { Color(Colors.GrayLight.rawValue) }
}

private enum Colors: String {
    case Yellow = "Mach1Yellow"
    case Darkets = "Mach1Darkest"
    case Dark = "Mach1Dark"
    case Light = "Mach1Light"
    case Gray = "Mach1Gray"
    case GrayLight = "Mach1GrayLight"
}
