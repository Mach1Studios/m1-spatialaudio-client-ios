//
//  SaveProfileChangesUseCaseImpl.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 8. 10. 2021..
//

import Foundation

private struct SaveProfileChangesUseCaseKey: InjectionKey {
    static var currentValue: SaveProfileChangesUseCase = SaveProfileChangesUseCaseImpl()
}

extension InjectedValues {
    var saveProfileChangesUseCase: SaveProfileChangesUseCase {
        get { Self[SaveProfileChangesUseCaseKey.self] }
        set { Self[SaveProfileChangesUseCaseKey.self] = newValue }
    }
}

actor SaveProfileChangesUseCaseImpl: SaveProfileChangesUseCase {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.profileRepository) private var repository: ProfileRepository
    
    func execute(params: ProfileForEdit, username: String, biography: String, coverImage: String, profileImage: String) async throws {
        logger.info("USE CASE: \(type(of: self))", LoggerCategoryType.EditProfile)
        let usernameTemp = params.userLogin != username ? username : params.userLogin
        let biographyTemp = params.userBiography != biography ? biography : params.userBiography
        let coverImageTemp = params.userCoverImage != coverImage ? coverImage : params.userCoverImage
        let profileImageTemp = params.userProfileImage != profileImage ? profileImage : params.userProfileImage
        
        let dto = EditProfileRequestDTO(id: params.id, username: usernameTemp, coverImage: coverImageTemp, profileImage: profileImageTemp, biography: biographyTemp)
        
        logger.info("Saving profile changes: \(dto)", LoggerCategoryType.EditProfile)
        try await repository.editProfile(dto: dto)
    }
}
