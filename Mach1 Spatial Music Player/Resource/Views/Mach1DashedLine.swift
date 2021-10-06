import SwiftUI

struct Mach1DashedLine: View {
    let orientation: DashedLineOrientation
    var body: some View {
        (orientation == .Horizontal ? AnyShape(HLine()) : AnyShape(VLine()))
            .stroke(style: StrokeStyle(lineWidth: Constants.LineWidth.normal,
                                       dash: [Constants.LineDashedLength.normal]))
            .foregroundColor(.Mach1Gray)
    }
}

enum DashedLineOrientation {
    case Horizontal
    case Vertical
}

// MARK: Preview

struct Mach1DashedLineHorizontal_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            Mach1DashedLine(orientation: .Horizontal)
        }
    }
}

struct Mach1DashedLineVertical_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            Mach1DashedLine(orientation: .Vertical)
        }
    }
}
