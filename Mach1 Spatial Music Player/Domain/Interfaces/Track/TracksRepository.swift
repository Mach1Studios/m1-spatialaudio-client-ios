import Foundation

protocol TracksRepository {
    func get(playlist: UUID) async throws -> [TrackDTO]
    func getFavourites(search: String?) async throws -> [TrackDTO]
}
