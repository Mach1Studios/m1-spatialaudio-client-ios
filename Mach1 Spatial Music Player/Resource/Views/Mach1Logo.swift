import SwiftUI

struct Mach1Logo: View {
    let dimension: Constants.Image.Dimension
    var body: some View {
        Image(Constants.Image.Custom.Mach1Logo.rawValue)
            .resizable()
            .frame(width: dimension.rawValue,
                   height: dimension.rawValue,
                   alignment: .center)
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
