import Foundation

protocol TracksRepository {
    func get(playlist: UUID) async throws -> PlaylistTracksDTO
    func getFavourites(search: String?) async throws -> [TrackDTO]
}
