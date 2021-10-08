import Foundation

private struct GetFavouriteTracksUseCaseKey: InjectionKey {
    static var currentValue: GetFavouriteTracksUseCase = GetFavouriteTracksUseCaseImpl()
}

extension InjectedValues {
    var getFavouriteTracksUseCase: GetFavouriteTracksUseCase {
        get { Self[GetFavouriteTracksUseCaseKey.self] }
        set { Self[GetFavouriteTracksUseCaseKey.self] = newValue }
    }
}

actor GetFavouriteTracksUseCaseImpl: GetFavouriteTracksUseCase {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.tracksRepository) private var repository: TracksRepository
    
    func execute(search: String?) async throws -> [Track] {
        logger.info("USE CASE: \(type(of: self))", LoggerCategoryType.Track)
        let response = try await repository.getFavourites(search: search)
        logger.info("Response get favourite tracks with search text \(String(describing: search)) : \(response)", LoggerCategoryType.Track)
        return response.map { Track($0) }
    }
}
