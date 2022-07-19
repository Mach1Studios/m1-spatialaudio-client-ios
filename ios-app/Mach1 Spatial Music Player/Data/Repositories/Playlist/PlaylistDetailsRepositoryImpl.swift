import Foundation
import Get

private struct PlaylistDetailsRepositoryKey: InjectionKey {
    static var currentValue: PlaylistDetailsRepository = PlaylistDetailsRepositoryImpl()
}

extension InjectedValues {
    var playlistDetailsRepository: PlaylistDetailsRepository {
        get { Self[PlaylistDetailsRepositoryKey.self] }
        set { Self[PlaylistDetailsRepositoryKey.self] = newValue }
    }
}

actor PlaylistDetailsRepositoryImpl: PlaylistDetailsRepository {
    @inject(\.apiClient) internal var apiClient: APIClient
    
    func details(id: UUID) async throws -> PlaylistDTO {
        return try await apiClient.send(.get("/playlists/\(id.uuidString.lowercased())")).value
    }
    
    func getPlaylistsForProfile(username: String) async throws -> UserPlaylistsDTO {
        return try await apiClient.send(.get("/users/\(username)")).value
    }
}

actor MockedPlaylistDetailsRepositoryImpl: PlaylistDetailsRepository {
    func details(id: UUID) async throws -> PlaylistDTO {
//        let playlists: [SectionedPlaylistResponseDTO] = try ReadFile.json(resource: .SectionedPlaylists)
//        let selectedPlaylist = playlists
//            .map { $0.items }
//            .joined()
//            .first { $0.id == id }
//        guard let playlist = selectedPlaylist else { throw "Playlist not found" }
//        return PlaylistDTO.init(id: playlist.id, name: playlist.name, url: playlist.url)
        throw ""
    }
    
    func getPlaylistsForProfile(username: String) async throws -> UserPlaylistsDTO {
        return try ReadFile.json(resource: .PlaylistsOfFriend)
    }
}
