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
    func getProfileInfo() async throws -> ProfileResponseDTO {
        throw "Not implemented"
    }
    
    func getProfileForEdit() async throws -> ProfileForEditResponseDTO {
        throw "Not implemented"
    }
    
    func editProfile(dto: EditProfileRequestDTO) async throws -> Void {
        throw "Not implemented"
    }
    
    func changePassword(dto: ChangeProfilePasswordRequestDTO) async throws -> Void {
        throw "Not implemented"
    }
    
    func getFriendProfile(id: UUID) async throws -> FriendProfileResponseDTO {
        throw "Not implemented"
    }
}

class MockedProfileRepositoryImpl: ProfileRepository {
    func getProfileInfo() async throws -> ProfileResponseDTO {
        return try ReadFile.json(resource: .Profile)
    }
    
    func getProfileForEdit() async throws -> ProfileForEditResponseDTO {
        return try ReadFile.json(resource: .EditProfile)
    }
    
    func editProfile(dto: EditProfileRequestDTO) async throws -> Void {
        print("Saving changes for: \(dto)")
    }
    
    func changePassword(dto: ChangeProfilePasswordRequestDTO) async throws -> Void {
        
    }
    
    func getFriendProfile(id: UUID) async throws -> FriendProfileResponseDTO {
        let friends: [FriendProfileResponseDTO] = try ReadFile.json(resource: .FriendProfile)
        let friend = friends.first(where: {
            if let fid = UUID.init(uuidString: $0.id) {
                    return fid == id
                } else {
                    return false
                }
        })
        if let profile = friend {
            return profile
        } else {
            throw "Friend profile does not exist"
        }
    }
}
