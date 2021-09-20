import SwiftUI

struct CorrugatedRectangle: Shape {
    func path(in rect: CGRect) -> Path {
        let mX = rect.width
        let mY = rect.height
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: mY * 0.25))
        path.addQuadCurve(
            to: CGPoint(x: mX * 0.5, y: mY * 0.25),
            control: CGPoint(x: mX * 0.25, y: 0))
        path.addQuadCurve(
            to: CGPoint(x: mX, y: mY * 0.25),
            control: CGPoint(x: mX * 0.75, y: mY * 0.5))
        path.addLine(to: CGPoint(x: mX, y: mY))
        path.addLine(to: CGPoint(x: 0, y: mY))
        path.addLine(to: CGPoint(x: 0, y: mY * 0.25))
        
        return path
    }
}

// MARK: Preview

struct CorrugatedShape_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Mach1Dark.ignoresSafeArea()
            CorrugatedRectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [.Mach1Dark, .Mach1Yellow]), startPoint: .bottom, endPoint: .top))
                .foregroundColor(.Mach1Yellow)
                .frame(width: UIScreen.main.bounds.width, height: 200)
        }
    }
}
