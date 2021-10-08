import SwiftUI

struct SearchFavoutireTracksView: View {
    @StateObject private var viewModel = FavouritesTracksViewModel()
    @Translate private var favouritesTracks = "Favorite tracks"
    @Translate private var search = "Search"
    @Translate private var noResults = "No results"
    @Translate private var errorTitle = "Error"
    
    init() {
        let coloredNavAppearance = UINavigationBarAppearance()
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = UIColor(Color.Mach1Dark)
        coloredNavAppearance.shadowColor = UIColor(Color.Mach1Dark)
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color.Mach1GrayLight)]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.Mach1GrayLight)]
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
        UIScrollView.appearance().backgroundColor = UIColor(Color.Mach1Dark)
    }
    
    var body: some View {
        NavigationView {
            Mach1View {
                self.observeUiState
                    .searchable(text: $viewModel.searchText)
                    .navigationTitle(Text(favouritesTracks))
            }.task { await viewModel.filter() }
        }.foregroundColor(.Mach1Light)
    }
    
    @ViewBuilder
    private var observeUiState: some View {
        switch viewModel.uiState {
        case .Loading:
            Mach1ProgressBar(shape: Circle(), height: Constants.Dimension.progressBar.rawValue, backgroundColor: .clear)
        case .Error(let error):
            Mach1Alert(errorTitle, description: error)
        case .Success(let tracks):
            List {
                ForEach(tracks, id: \.id) { TrackItemView(track: $0) }
                .listRowBackground(Color.Mach1Darkest)
            }
        case .NoResults:
            Text(noResults)
                .foregroundColor(.Mach1GrayLight)
                .textStyle(TitleStyle())
        }
    }
}

struct SearchFavoutireTracksView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFavoutireTracksView()
    }
}
