import SwiftUI

struct Mach1OrientationCardWithIndicatorsView: View {
    let width: CGFloat
    @Translate var up: String = "U"
    @Translate var down: String = "D"
    @Translate var left: String = "L"
    @Translate var right: String = "R"
    private let textWidth: CGFloat = 10
    
    var body: some View {
        ZStack {
            VStack {
                initText(up.uppercased())
                Mach1DashedLine(orientation: .Vertical)
                initText(down.uppercased())
            }
            HStack {
                initText(left.uppercased())
                Mach1DashedLine(orientation: .Horizontal)
                initText(right.uppercased())
            }
            Mach1OrientationCardView(width: width * 0.85)
        }
        .frame(width: width, height: width * Constants.OrientationCardAspectRatio.value + (textWidth * 4))
    }
    
    private func initText(_ text: String) -> some View {
        Text(text.uppercased())
            .foregroundColor(.Mach1Gray)
            .textStyle(SmallBodyStyle())
            .frame(width: textWidth)
    }
}

// MARK: Preview

struct Mach1OrientationCardWithIndicatorsView_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            Mach1OrientationCardWithIndicatorsView(width: UIScreen.main.bounds.width)
        }
    }
}
