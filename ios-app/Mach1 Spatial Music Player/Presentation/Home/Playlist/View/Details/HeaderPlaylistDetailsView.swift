import SwiftUI

struct HeaderPlaylistDetailsView: View {
    let playlist: Playlist
    private let height = UIScreen.main.bounds.height / 2.2
    @State private var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    var showToolbar: ((_ visible: Bool) -> Void)? = nil
    var body: some View {
        GeometryReader{ g in
            AsyncImage(
                url: URL(string: playlist.url ?? ""),
                transaction: Transaction(animation: .easeInOut)) { phase in
                    switch phase {
                    case .empty:
                        observeFrame(Mach1ProgressBar(shape: Rectangle(), height: Constants.Image.Dimension.Normal.rawValue, backgroundColor: .clear), g)
                    case .success(let image):
                        observeFrame(image.resizable().withDarkOverlay(), g)
                    case .failure:
                        observeFrame(Image(Constants.Image.Default.PlayList.rawValue).resizable().centerCropped().withDarkOverlay(), g)
                    @unknown default:
                        EmptyView()
                    }
                }
        }.frame(height: self.height)
    }
    
    func observeFrame<V: View>(_ v: V, _ g: GeometryProxy) -> some View {
        v.offset(y: g.frame(in: .global).minY > 0 ? -g.frame(in: .global).minY : 0)
            .frame(height: g.frame(in: .global).minY > 0 ? self.height + g.frame(in: .global).minY + UIApplication.shared.distanceFromNotchWithOrNot : self.height)
            .onReceive(self.time) { (_) in withAnimation { self.showToolbar?(-(g.frame(in: .global).minY) > self.height - 50) } }
            .frame(height: UIScreen.main.bounds.height / 2.2)
            .overlay(alignment: .trailing) { Overlay(title: self.playlist.title) }
    }
}

private struct Overlay: View {
    let title: String
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: Constants.Image.System.NotFavourite.rawValue).foregroundColor(.white)
                Image(systemName: Constants.Image.System.Option.rawValue).foregroundColor(.white)
            }.padding()
            Spacer()
            HStack {
                Text(title).textStyle(TitleStyle())
                Spacer()
                Image(systemName: Constants.Image.System.Repeat.rawValue).foregroundColor(.white)
                Image(systemName: Constants.Image.System.Shuffle.rawValue).foregroundColor(.white)
            }.padding()
        }
    }
}

// MARK: Preview

struct HeaderPlaylistDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderPlaylistDetailsView(
            playlist: Playlist(PlaylistDTO(
                id: UUID.init(),
                name: "Title",
                isPublic: true,
                owner: nil,
                tracks: [],
                url: nil
            )))
    }
}
