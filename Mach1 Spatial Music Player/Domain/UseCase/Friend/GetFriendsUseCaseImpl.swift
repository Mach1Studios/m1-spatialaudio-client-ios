//
//  GetFriendsUseCaseImpl.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 15. 10. 2021..
//

import Foundation

private struct GetFriendsUseCaseKey: InjectionKey {
    static var currentValue: GetFriendsUseCase = GetFriendsUseCaseImpl()
}

extension InjectedValues {
    var getFriendsUseCase: GetFriendsUseCase {
        get { Self[GetFriendsUseCaseKey.self] }
        set { Self[GetFriendsUseCaseKey.self] = newValue }
    }
}

actor GetFriendsUseCaseImpl: GetFriendsUseCase {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.friendRepository) private var repository: FriendRepository
    
    func execute() async throws -> [Friend] {
        logger.info("USE CASE: \(type(of: self))", LoggerCategoryType.Friend)
        let response = try await repository.getFriends()
        logger.info("Response get friends: \(response)", LoggerCategoryType.Friend)
        return response.map { Friend($0) }
    }
}
