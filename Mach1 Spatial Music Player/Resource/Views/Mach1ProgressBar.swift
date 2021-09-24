import SwiftUI

struct Mach1ProgressBar<V: Shape>: View {
    let shape: V
    let height: CGFloat
    let backgroundColor: Color
    private let heights: [CGFloat]
    @State private var shouldAnimate = false
    init(shape: V, height: CGFloat, backgroundColor: Color = .Mach1Darkest) {
        self.shape = shape
        self.height = height
        self.backgroundColor = backgroundColor
        self.heights = [height * 0.25, height * 0.1, height * 0.4, height * 0.2, height * 0.28, height * 0.13, height * 0.17, height * 0.12]
    }
    var body: some View {
        ZStack {
            self.shape
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: height)
                .foregroundColor(backgroundColor)
            HStack(alignment: .center, spacing: shouldAnimate ? 5 : 1) {
                ForEach(heights, id: \.self) { h in
                    let index = self.heights.firstIndex(of: h) ?? 0
                    Capsule(style: .continuous)
                        .fill(Color.Mach1Yellow)
                        .frame(width: 2, height: shouldAnimate ? h : 2)
                        .animation(Animation.easeInOut(duration: shouldAnimate ? (0.5 + (Double(index) * 0.01)) : 0.5).repeatForever(autoreverses: true), value: shouldAnimate)
                }
            }.onAppear { self.shouldAnimate = true }
        }
    }
}

// MARK: Preview

struct Mach1ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            Mach1ProgressBar(shape: Rectangle(), height: 400)
        }
    }
}
