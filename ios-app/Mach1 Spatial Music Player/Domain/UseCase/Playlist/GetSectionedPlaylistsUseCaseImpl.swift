import Foundation

private struct GetSectionedPlaylistsUseCaseKey: InjectionKey {
    static var currentValue: GetSectionedPlaylistsUseCase = GetSectionedPlaylistsUseCaseImpl()
}

extension InjectedValues {
    var getSectionedPlaylistsUseCase: GetSectionedPlaylistsUseCase {
        get { Self[GetSectionedPlaylistsUseCaseKey.self] }
        set { Self[GetSectionedPlaylistsUseCaseKey.self] = newValue }
    }
}

actor GetSectionedPlaylistsUseCaseImpl: GetSectionedPlaylistsUseCase {
    @inject(\.logger) private var logger: LoggerFactory
    @inject(\.sectionedPlaylistRepository) private var repository: SectionedPlaylistRepository
    
    func execute() async throws -> [SectionedPlaylist] {
        logger.info("USE CASE: \(type(of: self))", LoggerCategoryType.Playlist)
        let response = try await repository.get()
        logger.info("Response get sectioned playlist: \(response)", LoggerCategoryType.Playlist)
        return response.map { SectionedPlaylist($0) }.filter { !$0.items.isEmpty }
    }
}
