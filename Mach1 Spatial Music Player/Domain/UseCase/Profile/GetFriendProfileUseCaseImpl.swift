//
//  GetProfileFavouriteTracksUseCaseImpl.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 11. 10. 2021..
//

import Foundation

private struct GetFriendProfileUseCaseKey: InjectionKey {
    static var currentValue: GetFriendProfileUseCase = GetFriendProfileUseCaseImpl()
}

extension InjectedValues {
    var getFriendProfileUseCase: GetFriendProfileUseCase {
        get { Self[GetFriendProfileUseCaseKey.self] }
        set { Self[GetFriendProfileUseCaseKey.self] = newValue }
    }
}

actor GetFriendProfileUseCaseImpl: GetFriendProfileUseCase {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.profileRepository) private var repository: ProfileRepository
    
    func execute(id: UUID) async throws -> FriendProfile {
        logger.info("USE CASE: \(type(of: self))", LoggerCategoryType.FriendProfile)
        let response = try await repository.getFriendProfile(id: id)
        logger.info("Response get friend profile: \(response)", LoggerCategoryType.FriendProfile)
        return FriendProfile(response)
    }
}
