import Foundation

protocol SectionedPlaylistRepository {
    func get() async throws -> [SectionedPlaylistResponseDTO]
}
