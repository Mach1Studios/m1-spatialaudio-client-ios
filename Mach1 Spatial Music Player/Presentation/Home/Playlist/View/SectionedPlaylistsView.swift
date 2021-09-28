import SwiftUI

struct PlayListsView: View {
    @StateObject private var viewModel = SectionedPlaylistsViewModel()
    @Translate private var errorTitle = "Error"
    
    init() {
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        Mach1View {
            observeUiState.task { await viewModel.get() }
        }
    }
    
    @ViewBuilder
    private var observeUiState: some View {
        switch viewModel.uiState {
        case .Loading:
            Mach1ProgressBar(shape: Circle(), height: Constants.Dimension.progressBar, backgroundColor: .clear)
        case .Error(let error):
            Mach1Alert(errorTitle, description: error)
        case .Success(let sectionedPlaylist):
            Mach1SectionedView(sections: sectionedPlaylist)
        }
    }
}

struct PlayListsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayListsView()
    }
}
