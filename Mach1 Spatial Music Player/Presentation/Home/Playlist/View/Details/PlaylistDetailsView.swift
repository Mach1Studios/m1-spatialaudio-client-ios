import SwiftUI
import Combine

struct PlaylistDetailsView: View {
    let id: UUID
    @StateObject private var viewModel = PlaylistDetailsViewModel()
    @State private var showToolbar: Bool = false
    @Translate private var errorTitle = "Error"
    
    var body: some View {
        Mach1View {
            switch viewModel.uiState {
            case .Loading:
                Mach1ProgressBar(shape: Circle(), height: Constants.Dimension.progressBar, backgroundColor: .clear)
            case .Success(let playlist, let tracks):
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack{
                        HeaderPlaylistDetailsView(playlist: playlist) { showToolbar = $0 }
                        VStack(spacing: Mach1Margin.Small.rawValue) {
                            ForEach(tracks, id: \.id) { TrackItemView(track: $0).padding(.bottom) }
                        }.padding()
                        Spacer()
                    }
                })
                if showToolbar {
                    VStack {
                        ToolbarView(title: playlist.title).ignoresSafeArea()
                        Spacer()
                    }
                }
            case .Error(let error):
                Mach1Alert(errorTitle, description: error)
            }
        }.task { await viewModel.getPlaylist(id: self.id) }
    }
}

// MARK: Preview

struct PlaylistDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistDetailsView(id: UUID.init())
    }
}
