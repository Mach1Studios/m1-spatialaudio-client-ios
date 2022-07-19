//
//  ProfileRepositoryImpl.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 7. 10. 2021..
//

import Foundation
import Get

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
    @inject(\.apiClient) private var apiClient: APIClient
    
    func getProfileInfo() async throws -> ProfileResponseDTO {
        return try await apiClient.send(.get("/users/me")).value
    }
    
    func getProfileForEdit() async throws -> ProfileForEditResponseDTO {
        return try await apiClient.send(.get("/users/me")).value
    }
    
    func editProfile(_ username: String, dto: EditProfileRequestDTO) async throws -> Void {
        try await apiClient.send(.patch("/users/\(username)", body: dto))
    }
    
    func changePassword(dto: ChangeProfilePasswordRequestDTO) async throws -> Void {
        throw "Not implemented"
    }
    
    func getFriendProfile(username: String) async throws -> FriendProfileResponseDTO {
        try await apiClient.send(.get("/users/\(username)")).value
    }
}

class MockedProfileRepositoryImpl: ProfileRepository {
    func getProfileInfo() async throws -> ProfileResponseDTO {
        return try ReadFile.json(resource: .Profile)
    }
    
    func getProfileForEdit() async throws -> ProfileForEditResponseDTO {
        return try ReadFile.json(resource: .EditProfile)
    }
    
    func editProfile(_ username: String, dto: EditProfileRequestDTO) async throws -> Void {
        print("Saving changes for \(username): \(dto)")
    }
    
    func changePassword(dto: ChangeProfilePasswordRequestDTO) async throws -> Void {
        
    }
    
    func getFriendProfile(username: String) async throws -> FriendProfileResponseDTO {
        throw ""
//        let friends: [FriendProfileResponseDTO] = try ReadFile.json(resource: .FriendProfile)
//        let friend = friends.first(where: {
//            if let fid = UUID.init() {
//                    return fid == id
//                } else {
//                    return false
//                }
//        })
//        if let profile = friend {
//            return profile
//        } else {
//            throw "Friend profile does not exist"
//        }
    }
}
