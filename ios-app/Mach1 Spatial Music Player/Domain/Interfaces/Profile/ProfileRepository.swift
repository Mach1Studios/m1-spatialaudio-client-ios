//
//  ProfileRepository.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 7. 10. 2021..
//

import Foundation

protocol ProfileRepository {
    func getProfileInfo() async throws -> ProfileResponseDTO
    func getProfileForEdit() async throws -> ProfileForEditResponseDTO
    func editProfile(_ username: String, dto: EditProfileRequestDTO) async throws -> Void
    func changePassword(dto: ChangeProfilePasswordRequestDTO) async throws -> Void
    func getFriendProfile(username: String) async throws -> FriendProfileResponseDTO
}
