//
//  GetProfileFavouriteTracksUseCaseImpl.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 11. 10. 2021..
//

import Foundation

private struct GetProfileFavouriteTracksUseCaseKey: InjectionKey {
    static var currentValue: GetProfileFavouriteTracksUseCase = GetProfileFavouriteTracksUseCaseImpl()
}

extension InjectedValues {
    var getProfileFavouriteTracksUseCase: GetProfileFavouriteTracksUseCase {
        get { Self[GetProfileFavouriteTracksUseCaseKey.self] }
        set { Self[GetProfileFavouriteTracksUseCaseKey.self] = newValue }
    }
}

actor GetProfileFavouriteTracksUseCaseImpl: GetProfileFavouriteTracksUseCase {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.profileRepository) private var repository: ProfileRepository
    
    func execute() async throws -> ProfileFavouriteTracks {
        logger.info("USE CASE: \(type(of: self))", LoggerCategoryType.ProfileFavouriteTracks)
        let response = try await repository.getProfileFavouriteTracks()
        logger.info("Response get profile favourite tracks: \(response)", LoggerCategoryType.ProfileFavouriteTracks)
        return ProfileFavouriteTracks(response)
    }
}
