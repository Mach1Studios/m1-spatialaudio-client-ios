import Foundation

private struct FindFriendUseCaseKey: InjectionKey {
    static var currentValue: FindFriendUseCase = FindFriendUseCaseImpl()
}

extension InjectedValues {
    var findFriendUseCase: FindFriendUseCase {
        get { Self[FindFriendUseCaseKey.self] }
        set { Self[FindFriendUseCaseKey.self] = newValue }
    }
}

actor FindFriendUseCaseImpl: FindFriendUseCase {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.friendRepository) private var repository: FriendRepository
    
    func execute(search: String?) async throws -> [Friend] {
        logger.info("USE CASE: \(type(of: self))", LoggerCategoryType.Friend)
        let response = try await repository.find(search: search)
        logger.info("Response find friends with text \(String(describing: search)) : \(response)", LoggerCategoryType.Friend)
        return response.map { Friend($0) }
    }
}
