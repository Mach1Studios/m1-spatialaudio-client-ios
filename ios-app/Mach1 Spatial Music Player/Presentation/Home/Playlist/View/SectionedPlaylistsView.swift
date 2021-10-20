import SwiftUI

struct SectionedPlayistsView: View {
    @StateObject private var viewModel = SectionedPlaylistsViewModel()
    @Translate private var errorTitle = "Error"
    
    init() {
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        Mach1View {
            observeUiState.task { await viewModel.get() }
        }.sheet(isPresented: $viewModel.isPlaylistDetailsVisible) {
            self.viewModel.unselect()
        } content: {
            if let id = self.viewModel.selectedPlayList { PlaylistDetailsView(id: id) }
        }
    }
    
    @ViewBuilder
    private var observeUiState: some View {
        switch viewModel.uiState {
        case .Loading:
            Mach1ProgressBar(shape: Circle(), height: Constants.Dimension.progressBar.rawValue, backgroundColor: .clear)
        case .Error(let error):
            Mach1Alert(errorTitle, description: error)
        case .Success(let sectionedPlaylist):
            Mach1SectionedView(sections: sectionedPlaylist) { id in self.viewModel.select(playlist: id) }
        }
    }
}

// MARK: Preview

struct SectionedPlayistsView_Previews: PreviewProvider {
    static var previews: some View {
        SectionedPlayistsView()
    }
}
