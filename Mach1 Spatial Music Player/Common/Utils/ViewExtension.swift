import SwiftUI

extension View {
    func withShadow() -> some View {
        return self.shadow(color: .Mach1Dark, radius: Constants.Shadow.value)
    }
    
    func withDarkOverlay() -> some View {
        return self.overlay(Color.Mach1Dark.opacity(Constants.Opacity.value))
    }
    
    func withCenterTransition() -> some View {
        return self.transition(.scale(scale: 0.3, anchor: .center))
    }
    
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        ZStack {
            NavigationLink(destination: view, isActive: binding) {
                EmptyView()
            }.opacity(0)
        }
    }
}
