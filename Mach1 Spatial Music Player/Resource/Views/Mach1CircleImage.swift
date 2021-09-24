import Foundation
import SwiftUI

struct Mach1CircleImage: View {
    let url: URL?
    var dimension: Constants.Image.Dimension
    var defaultSystemImage: Constants.Image.Default
    var action: (() -> Void)? = nil
    var body: some View {
        Button { action?() } label: {
            AsyncImage(
                url: url,
                transaction: Transaction(animation: .easeInOut)) { phase in
                switch phase {
                case .empty:
                    Mach1ProgressBar(
                        shape: Circle(),
                        height: dimension.rawValue)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .withCenterTransition()
                case .failure:
                    ZStack {
                        Circle()
                            .frame(width: dimension.rawValue, height: dimension.rawValue)
                            .foregroundColor(.Mach1Darkest)
                        Image(systemName: defaultSystemImage.rawValue)
                            .resizable()
                            .accentColor(.Mach1Yellow)
                            .frame(width: dimension.rawValue * 0.3, height: dimension.rawValue * 0.3)
                            .withCenterTransition()
                    }
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: dimension.rawValue, height: dimension.rawValue)
            .clipShape(Circle())
        }
    }
}

// MARK: Preview

struct Mach1CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            Mach1CircleImage(
            url: URL(string: ""),
            dimension: Constants.Image.Dimension.Big,
            defaultSystemImage: Constants.Image.Default.Person
            ) { print("Image clicked") }
        }
    }
}



