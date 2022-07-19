//
//  GetProfileInfoUseCaseImpl.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 7. 10. 2021..
//

import Foundation

private struct GetProfileInfoUseCaseKey: InjectionKey {
    static var currentValue: GetProfileInfoUseCase = GetProfileInfoUseCaseImpl()
}

extension InjectedValues {
    var getProfileInfoUseCase: GetProfileInfoUseCase {
        get { Self[GetProfileInfoUseCaseKey.self] }
        set { Self[GetProfileInfoUseCaseKey.self] = newValue }
    }
}

actor GetProfileInfoUseCaseImpl: GetProfileInfoUseCase {
    @inject(\.logger) private var logger: LoggerFactory
    @inject(\.profileRepository) private var repository: ProfileRepository
    
    func execute() async throws -> Profile {
        logger.info("USE CASE: \(type(of: self))", LoggerCategoryType.Profile)
        let response = try await repository.getProfileInfo()
        logger.info("Response get profile info: \(response)", LoggerCategoryType.Playlist)
        return Profile(response)
    }
}
