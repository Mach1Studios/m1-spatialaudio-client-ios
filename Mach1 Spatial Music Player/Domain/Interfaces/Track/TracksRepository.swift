import Foundation

protocol TracksRepository {
    func get(playlist: UUID) async throws -> [TrackDTO]
}
