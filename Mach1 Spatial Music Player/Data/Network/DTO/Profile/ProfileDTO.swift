//
//  ProfileDTO.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 7. 10. 2021..
//

import Foundation

struct ProfileRequestDTO: BaseProfileForGetRequestDTO {
    let id: String
}

struct ProfileResponseDTO: Codable, Equatable {
    let id: String
    let username: String
    let coverImage: String?
    let profileImage: String?
    let numberOfFriends: Int
}

struct ProfileForEditRequestDTO: BaseProfileForGetRequestDTO {
    let id: String
}

struct ProfileForEditResponseDTO: Codable, Equatable {
    let id: String
    let username: String
    let coverImage: String?
    let profileImage: String?
    let biography: String?
}

struct EditProfileRequestDTO: Codable, Equatable {
    let id: String
    let username: String
    let coverImage: String?
    let profileImage: String?
    let biography: String?
}

struct EditProfileResponseDTO: BaseProfileActionResponseDTO {
    var responseCode: Int?
    var errorMessage: String?
}

struct ChangeProfilePasswordRequestDTO: Codable, Equatable {
    let profileId: String
    let oldPassword: String
    let newPassword: String
}

struct ChangeProfilePasswordResponseDTO: BaseProfileActionResponseDTO {
    var responseCode: Int?
    var errorMessage: String?
}
