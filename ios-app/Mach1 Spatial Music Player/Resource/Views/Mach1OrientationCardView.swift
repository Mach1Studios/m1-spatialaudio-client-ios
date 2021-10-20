import SwiftUI

struct Mach1OrientationCardView: View {
    let width: CGFloat
    private let innerWidth: CGFloat
    @Translate var front = "Front"
    
    init(width: CGFloat) {
        self.width = width
        innerWidth = self.width * 0.3
    }
    
    var body: some View {
        ZStack {
            shape(width, Constants.LineWidth.normal)
            shape(innerWidth, Constants.LineWidth.thick)
                .overlay(
                    Text(front.uppercased())
                        .textStyle(TitleStyle())
                        .minimumScaleFactor(0.0001)
                        .lineLimit(1)
                        .padding(Mach1Margin.VSmall.rawValue))
        }
    }
    
    private func shape(_ width: CGFloat, _ lineWidth: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: Constants.Rounded.normal.rawValue)
            .stroke(Color.Mach1Yellow, lineWidth: lineWidth)
            .frame(width: width, height: width * Constants.OrientationCardAspectRatio.value)
            .background(.clear)
    }
}

// MARK: Preview

struct Mach1OrientationCardView_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            Mach1OrientationCardView(width: UIScreen.main.bounds.width)
        }
    }
}
