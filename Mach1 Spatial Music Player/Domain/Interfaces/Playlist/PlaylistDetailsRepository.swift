import Foundation

protocol PlaylistDetailsRepository {
    func details(id: UUID) async throws -> PlaylistDTO
}
