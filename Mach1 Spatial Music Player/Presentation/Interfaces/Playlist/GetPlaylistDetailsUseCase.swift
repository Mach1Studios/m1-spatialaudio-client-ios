import Foundation

protocol GetPlaylistDetailsUseCase {
    func execute(id: UUID) async throws -> Playlist
}
