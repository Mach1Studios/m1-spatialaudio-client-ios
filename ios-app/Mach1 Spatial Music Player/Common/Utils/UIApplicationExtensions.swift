import Foundation
import UIKit

extension UIApplication {
    var distanceFromNotchWithOrNot: CGFloat {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .first(where: { $0 is UIWindowScene })
                .flatMap({ $0 as? UIWindowScene })?.windows
                .first(where: \.isKeyWindow)?
                .safeAreaInsets
                .top ?? Mach1Margin.Big.rawValue
        } else {
            return Mach1Margin.Big.rawValue
        }
    }
}
