import Foundation

protocol PlaylistDetailsRepository {
    func details(id: UUID) async throws -> PlaylistDTO
    func getPlaylistsForProfile(username: String) async throws -> UserPlaylistsDTO
}
