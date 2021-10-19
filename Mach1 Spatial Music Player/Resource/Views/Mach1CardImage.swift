import SwiftUI

struct Mach1CardImage: View {
    let title: String
    let url: URL?
    let height: Constants.Image.Dimension
    let defaultImage: Constants.Image.Default
    var rounded: Constants.Rounded = .normal
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button { action?() } label: {
            AsyncImage(
                url: url,
                transaction: Transaction(animation: .easeInOut)) { phase in
                    switch phase {
                    case .empty:
                        Mach1ProgressBar(shape: Rectangle(), height: height.rawValue).withDarkOverlay()
                    case .success(let image):
                        self.applyStyle(image)
                    case .failure:
                        self.applyStyle(Image(defaultImage.rawValue))
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: height.rawValue)
                .overlay(self.initTitle, alignment: .bottomLeading)
        }
    }
    
    private var initTitle: some View {
        return Text(title)
            .foregroundColor(Color.white)
            .textStyle(SubTitleStyle())
            .withShadow()
            .padding()
    }
    
    private func applyStyle(_ image: Image) -> some View {
        return image
            .resizable()
            .centerCropped()
            .clipShape(RoundedRectangle(cornerRadius: rounded.rawValue))
            .frame(height: height.rawValue)
            .withDarkOverlay()
            .withCenterTransition()
    }
}

// MARK: Preview

struct Mach1CardImage_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            Mach1CardImage(
                title: "Title",
                url: URL(string: ""),
                height: Constants.Image.Dimension.Big,
                defaultImage: Constants.Image.Default.PlayList
            )
        }
    }
}
