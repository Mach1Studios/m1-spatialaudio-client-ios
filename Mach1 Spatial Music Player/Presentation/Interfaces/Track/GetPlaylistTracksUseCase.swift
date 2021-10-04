import Foundation

protocol GetPlaylistTracksUseCase {
    func execute(id: UUID) async throws -> [Track]
}
