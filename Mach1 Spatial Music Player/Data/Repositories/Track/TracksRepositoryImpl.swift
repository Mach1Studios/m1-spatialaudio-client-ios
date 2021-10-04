import Foundation

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
    func get(playlist: UUID) async throws -> [TrackDTO] {
        throw "Not implemented"
    }
}

actor MockedTracksRepositoryImpl: TracksRepository {
    func get(playlist: UUID) async throws -> [TrackDTO] {
        return try ReadFile.json(resource: .Tracks)
    }
}

