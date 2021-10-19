import SwiftUI

class FavouritesTracksViewModel: ObservableObject {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.getFavouriteTracksUseCase) private var getFavouriteTracksUseCase: GetFavouriteTracksUseCase
    @Published var searchText = ""
    @Published private(set) var uiState: FavouriteTracksState = .Loading
    @Published var isTrackSelected: Bool = false
    @Published private(set) var track: Track? = nil
    
    @MainActor
    func filter() async {
        self.uiState = .Loading
        do {
            let tracks = try await getFavouriteTracksUseCase.execute(search: searchText)
            self.uiState = tracks.isEmpty ? .NoResults : .Success(tracks)
        } catch {
            logger.error("Error when get favoutires tracks: \(error)", LoggerCategoryType.Track)
            self.uiState = .Error(error.localizedDescription)
        }
    }
    
    func selectTrack(_ track: Track) {
        self.track = track
        self.isTrackSelected = true
    }
    
    func unselectTrack() {
        self.track = nil
        self.isTrackSelected = false
    }
}

enum FavouriteTracksState {
    case Loading
    case Error(String)
    case Success([Track])
    case NoResults
}
