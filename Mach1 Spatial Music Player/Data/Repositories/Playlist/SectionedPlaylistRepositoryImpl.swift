import Foundation

private struct SectionedPlaylistRepositoryKey: InjectionKey {
    static var currentValue: SectionedPlaylistRepository = SectionedPlaylistRepositoryImpl()
}

extension InjectedValues {
    var sectionedPlaylistRepository: SectionedPlaylistRepository {
        get { Self[SectionedPlaylistRepositoryKey.self] }
        set { Self[SectionedPlaylistRepositoryKey.self] = newValue }
    }
}

class SectionedPlaylistRepositoryImpl: SectionedPlaylistRepository {
    func get() async throws -> [SectionedPlaylistResponseDTO] {
        throw "Not implemented"
    }
}

class MockedSectionedPlaylistRepositoryImpl: SectionedPlaylistRepository {
    func get() async throws -> [SectionedPlaylistResponseDTO] {
        return try ReadFile.json(resource: .SectionedPlaylists)
    }
}