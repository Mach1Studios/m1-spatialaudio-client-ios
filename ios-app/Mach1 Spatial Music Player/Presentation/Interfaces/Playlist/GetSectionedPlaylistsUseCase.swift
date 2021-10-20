import Foundation

protocol GetSectionedPlaylistsUseCase {
    func execute() async throws -> [SectionedPlaylist]
}


