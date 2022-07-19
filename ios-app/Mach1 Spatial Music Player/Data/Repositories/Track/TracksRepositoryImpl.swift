import Foundation
import Get

private struct TracksRepositoryKey: InjectionKey {
    static var currentValue: TracksRepository = TracksRepositoryImpl()
}

extension InjectedValues {
    var tracksRepository: TracksRepository {
        get { Self[TracksRepositoryKey.self] }
        set { Self[TracksRepositoryKey.self] = newValue }
    }
}

actor TracksRepositoryImpl: TracksRepository {
    @inject(\.apiClient) internal var apiClient: APIClient
    
    func get(playlist: UUID) async throws -> PlaylistTracksDTO {
        return try await apiClient.send(.get("/playlists/\(playlist.uuidString.lowercased())")).value
    }
    
    func getFavourites(search: String?) async throws -> [TrackDTO] {
        throw "Not implemented"
    }
}

actor MockedTracksRepositoryImpl: TracksRepository {
    func get(playlist: UUID) async throws -> PlaylistTracksDTO {
        return try ReadFile.json(resource: .Tracks)
    }
    
    func getFavourites(search: String?) async throws -> [TrackDTO] {
        let tracks: [TrackDTO] = try ReadFile.json(resource: .Tracks)
        guard let searchText = search, !searchText.isEmpty else { return tracks }
        return tracks.filter { $0.name.contains(searchText) }
    }
}

