import Foundation
import Get

private struct SectionedPlaylistRepositoryKey: InjectionKey {
    static var currentValue: SectionedPlaylistRepository = SectionedPlaylistRepositoryImpl()
}

extension InjectedValues {
    var sectionedPlaylistRepository: SectionedPlaylistRepository {
        get { Self[SectionedPlaylistRepositoryKey.self] }
        set { Self[SectionedPlaylistRepositoryKey.self] = newValue }
    }
}

actor SectionedPlaylistRepositoryImpl: SectionedPlaylistRepository {
    @inject(\.apiClient) internal var apiClient: APIClient
    
    func get() async throws -> [SectionedPlaylistResponseDTO] {
        return try await apiClient.send(.get("/playlists/getByType")).value
    }
}

actor MockedSectionedPlaylistRepositoryImpl: SectionedPlaylistRepository {
    func get() async throws -> [SectionedPlaylistResponseDTO] {
        return try ReadFile.json(resource: .SectionedPlaylists)
    }
}
