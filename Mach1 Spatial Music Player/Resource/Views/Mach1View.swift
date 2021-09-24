import Foundation
import SwiftUI

struct Mach1View<Content>: View where Content: View {
    private let content: Content
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body : some View {
        ZStack {
            Color.Mach1Dark.ignoresSafeArea()
            content
        }
    }
}

