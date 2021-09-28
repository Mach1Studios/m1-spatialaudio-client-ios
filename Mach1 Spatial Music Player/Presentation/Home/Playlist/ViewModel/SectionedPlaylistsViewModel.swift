import Foundation
import SwiftUI

class SectionedPlaylistsViewModel: ObservableObject {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.getSectionedPlaylistsUseCase) private var getSectionedPlaylistsUseCase: GetSectionedPlaylistsUseCase
    @Published private(set) var uiState: SectionedPlayListsState = .Loading
    
    @MainActor
    func get() async {
        self.uiState = .Loading
        do {
            self.uiState = .Success(try await getSectionedPlaylistsUseCase.execute())
        } catch {
            logger.error("Error when get sectioned playlists: \(error)", LoggerCategoryType.Playlist)
            self.uiState = .Error(error.localizedDescription)
        }
    }
}

enum SectionedPlayListsState {
    case Loading
    case Error(String)
    case Success([SectionedPlaylist])
}
