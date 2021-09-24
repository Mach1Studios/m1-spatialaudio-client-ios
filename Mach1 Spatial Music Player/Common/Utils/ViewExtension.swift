import SwiftUI

extension View {
    func withShadow() -> some View {
        return self.shadow(color: .Mach1Dark, radius: Constants.Shadow.value)
    }
    
    func withBlur() -> some View {
        return self.blur(radius: Constants.Blur.value)
    }
    
    func withCenterTransition() -> some View {
        return self.transition(.scale(scale: 0.1, anchor: .center))
    }
}
