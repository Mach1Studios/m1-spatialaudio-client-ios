import Foundation

private struct GetPlaylistTracksUseCaseKey: InjectionKey {
    static var currentValue: GetPlaylistTracksUseCase = GetPlaylistTracksUseCaseImpl()
}

extension InjectedValues {
    var getPlaylistTracksUseCase: GetPlaylistTracksUseCase {
        get { Self[GetPlaylistTracksUseCaseKey.self] }
        set { Self[GetPlaylistTracksUseCaseKey.self] = newValue }
    }
}

actor GetPlaylistTracksUseCaseImpl: GetPlaylistTracksUseCase {
    @inject(\.logger) private var logger: LoggerFactory
    @inject(\.tracksRepository) private var repository: TracksRepository
    
    func execute(id: UUID) async throws -> [Track] {
        logger.info("USE CASE: \(type(of: self))", LoggerCategoryType.Playlist)
        let response = try await repository.get(playlist: id)
        logger.info("Response get tracks playlist with id \(id) : \(response)", LoggerCategoryType.Playlist)
        
        return response.tracks.isEmpty ? [] : response.tracks.map { Track($0) }.sorted()
    }
}
