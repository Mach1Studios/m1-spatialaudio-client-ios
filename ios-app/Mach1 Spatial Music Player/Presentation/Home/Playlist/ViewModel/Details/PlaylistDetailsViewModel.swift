import Foundation
import SwiftUI

class PlaylistDetailsViewModel: ObservableObject {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.getPlaylistDetailsUseCase) private var getPlaylistDetails: GetPlaylistDetailsUseCase
    @Inject(\.getPlaylistTracksUseCase) private var getPlaylistTracks: GetPlaylistTracksUseCase
    @Published private(set) var uiState: PlaylistDetailsState = .Loading
    @Published var isTrackSelected: Bool = false
    @Published private(set) var track: Track? = nil
    
    @MainActor
    func getPlaylist(id: UUID) async {
        do {
            let tracks = try await getPlaylistTracks.execute(id: id)
            let details = try await getPlaylistDetails.execute(id: id)
            
            self.uiState = await .Success(try details, try tracks)
        } catch {
            logger.error("Error when get playlist \(id): \(error)", LoggerCategoryType.Playlist)
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

enum PlaylistDetailsState {
    case Loading
    case Error(String)
    case Success(Playlist, [Track])
}
