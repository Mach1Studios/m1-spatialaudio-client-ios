import Foundation
import SwiftUI

class SectionedPlaylistsViewModel: ObservableObject {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.getSectionedPlaylistsUseCase) private var getSectionedPlaylistsUseCase: GetSectionedPlaylistsUseCase
    @Published private(set) var uiState: SectionedPlayListsState = .Loading
    @Published private(set) var selectedPlayList: UUID? = nil
    @Published var isPlaylistDetailsVisible: Bool = false
    
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
    
    func select(playlist: UUID) {
        self.selectedPlayList = playlist
        self.isPlaylistDetailsVisible = true
    }
    
    func unselect() {
        self.selectedPlayList = nil
        self.isPlaylistDetailsVisible = false
    }
}

enum SectionedPlayListsState {
    case Loading
    case Error(String)
    case Success([SectionedPlaylist])
}
