import Foundation

private struct GetPlaylistDetailsUseCaseKey: InjectionKey {
    static var currentValue: GetPlaylistDetailsUseCase = GetPlaylistDetailsUseCaseImpl()
}

extension InjectedValues {
    var getPlaylistDetailsUseCase: GetPlaylistDetailsUseCase {
        get { Self[GetPlaylistDetailsUseCaseKey.self] }
        set { Self[GetPlaylistDetailsUseCaseKey.self] = newValue }
    }
}

actor GetPlaylistDetailsUseCaseImpl: GetPlaylistDetailsUseCase {
    @inject(\.logger) private var logger: LoggerFactory
    @inject(\.playlistDetailsRepository) private var repository: PlaylistDetailsRepository
    
    func execute(id: UUID) async throws -> Playlist {
        logger.info("USE CASE: \(type(of: self))", LoggerCategoryType.Playlist)
        let response = try await repository.details(id: id)
        logger.info("Response get playlist with id \(id) : \(response)", LoggerCategoryType.Playlist)
        return Playlist(response)
    }
}
