import Foundation

protocol PlaylistDetailsRepository {
    func details(id: UUID) async throws -> PlaylistDTO
    func getPlaylistsForProfile(profileId: UUID) async throws -> [PlaylistItemDTO]
}
