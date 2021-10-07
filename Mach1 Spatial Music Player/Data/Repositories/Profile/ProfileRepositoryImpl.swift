//
//  ProfileRepositoryImpl.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 7. 10. 2021..
//

import Foundation

private struct ProfileRepositoryKey: InjectionKey {
    static var currentValue: ProfileRepository = ProfileRepositoryImpl()
}

extension InjectedValues {
    var profileRepository: ProfileRepository {
        get { Self[ProfileRepositoryKey.self] }
        set { Self[ProfileRepositoryKey.self] = newValue }
    }
}

class ProfileRepositoryImpl: ProfileRepository {
    func getProfileInfo(dto: ProfileRequestDTO) async throws -> ProfileResponseDTO {
        throw "Not implemented"
    }
    
    func getProfileForEdit(dto: ProfileForEditRequestDTO) async throws -> ProfileForEditResponseDTO {
        throw "Not implemented"
    }
    
    func editProfile(dto: EditProfileRequestDTO) async throws -> EditProfileResponseDTO {
        throw "Not implemented"
    }
    
    func changePassword(dto: ChangeProfilePasswordRequestDTO) async throws -> ChangeProfilePasswordResponseDTO {
        throw "Not implemented"
    }
}

class MockedProfileRepositoryImpl: ProfileRepository {
    func getProfileInfo(dto: ProfileRequestDTO) async throws -> ProfileResponseDTO {
        //TODO: implementirati
        throw "Not implemented"
    }
    
    func getProfileForEdit(dto: ProfileForEditRequestDTO) async throws -> ProfileForEditResponseDTO {
        //TODO: implementirati
        throw "Not implemented"
    }
    
    func editProfile(dto: EditProfileRequestDTO) async throws -> EditProfileResponseDTO {
        //TODO: implementirati
        throw "Not implemented"
    }
    
    func changePassword(dto: ChangeProfilePasswordRequestDTO) async throws -> ChangeProfilePasswordResponseDTO {
        //TODO: implementirati
        throw "Not implemented"
    }
}
