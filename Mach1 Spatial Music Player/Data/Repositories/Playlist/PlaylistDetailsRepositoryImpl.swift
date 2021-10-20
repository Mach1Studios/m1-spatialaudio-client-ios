import Foundation

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
    func details(id: UUID) async throws -> PlaylistDTO {
        throw "Not implemented"
    }
    
    func getPlaylistsForProfile(profileId: UUID) async throws -> [PlaylistItemDTO] {
        throw "Not implemented"
    }
}

actor MockedPlaylistDetailsRepositoryImpl: PlaylistDetailsRepository {
    func details(id: UUID) async throws -> PlaylistDTO {
        let playlists: [SectionedPlaylistResponseDTO] = try ReadFile.json(resource: .SectionedPlaylists)
        let selectedPlaylist = playlists
            .map { $0.items }
            .joined()
            .first { $0.id == id }
        guard let playlist = selectedPlaylist else { throw "Playlist not found" }
        return PlaylistDTO.init(id: playlist.id, title: playlist.title, url: playlist.url)
    }
    
    func getPlaylistsForProfile(profileId: UUID) async throws -> [PlaylistItemDTO] {
        return try ReadFile.json(resource: .PlaylistsOfFriend)
    }
}
