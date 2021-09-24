import SwiftUI

struct Mach1Logo: View {
    let dimension: Constants.Image.Dimension
    var body: some View {
        Image("Logo")
            .resizable()
            .frame(width: Constants.Image.Dimension.Big.rawValue,
                   height: Constants.Image.Dimension.Big.rawValue, alignment: .center)
    }
}

// MARK: Preview

struct Mach1Logo_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            Mach1Logo(dimension: .Big)
        }
    }
}
