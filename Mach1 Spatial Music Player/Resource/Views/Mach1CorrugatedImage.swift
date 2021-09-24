import SwiftUI

struct Mach1CorrugatedImage: View {
    let url: URL?
    var height: Constants.Image.Dimension
    let defaultImage: Constants.Image.Default
    
    var body: some View {
        ZStack {
            AsyncImage(
                url: url,
                transaction: Transaction(animation: .easeInOut)) { phase in
                    switch phase {
                    case .empty:
                        Mach1ProgressBar(shape: Rectangle(), height: height.rawValue)
                    case .success(let image):
                        image.centerCropped()
                    case .failure:
                        Image(defaultImage.rawValue).centerCropped()
                    @unknown default:
                        EmptyView()
                    }
                }.frame(height: height.rawValue)
            VStack {
                Spacer()
                CorrugatedRectangle()
                    .fill(Color.Mach1Dark)
                    .frame(height: height.rawValue * 0.33)
            }.frame(height: height.rawValue)
        }
    }
}

// MARK: Preview

struct Mach1CorrugatedImage_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            Mach1CorrugatedImage(
                url: URL(string: ""),
                height: Constants.Image.Dimension.VeryBig,
                defaultImage: Constants.Image.Default.PlayList)
        }
    }
}
