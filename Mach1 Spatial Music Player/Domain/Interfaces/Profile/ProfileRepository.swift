//
//  ProfileRepository.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 7. 10. 2021..
//

import Foundation

protocol ProfileRepository {
    func getProfileInfo(dto: ProfileRequestDTO) async throws -> ProfileResponseDTO
    func getProfileForEdit(dto: ProfileForEditRequestDTO) async throws -> ProfileForEditResponseDTO
    func editProfile(dto: EditProfileRequestDTO) async throws -> EditProfileResponseDTO
    func changePassword(dto: ChangeProfilePasswordRequestDTO) async throws -> ChangeProfilePasswordResponseDTO
}