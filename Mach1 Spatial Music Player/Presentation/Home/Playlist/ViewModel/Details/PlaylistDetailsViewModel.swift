import Foundation
import SwiftUI

class PlaylistDetailsViewModel: ObservableObject {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.getPlaylistDetailsUseCase) private var getPlaylistDetails: GetPlaylistDetailsUseCase
    @Inject(\.getPlaylistTracksUseCase) private var getPlaylistTracks: GetPlaylistTracksUseCase
    @Published private(set) var uiState: PlaylistDetailsState = .Loading
    
    @MainActor
    func getPlaylist(id: UUID) async {
        do {
            async let details = getPlaylistDetails.execute(id: id)
            async let tracks = getPlaylistTracks.execute(id: id)
            self.uiState = await .Success(try details, try tracks)
        } catch {
            logger.error("Error when get playlist \(id): \(error)", LoggerCategoryType.Playlist)
            self.uiState = .Error(error.localizedDescription)
        }
    }
}

enum PlaylistDetailsState {
    case Loading
    case Error(String)
    case Success(Playlist, [Track])
}
