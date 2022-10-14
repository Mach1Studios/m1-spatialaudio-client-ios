//
//  ProfileDTO.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 7. 10. 2021..
//

import Foundation

struct ProfileResponseDTO : Codable, Equatable {
    let user: UserProfileDTO
    let coverImage: String?
    let profileImage: String?
    let numberOfFriends: Int?
}

struct UserProfileDTO : Codable, Equatable {
    let id: String
    let nickname:  String
    let email: String
}

struct ProfileForEditResponseDTO : Codable, Equatable {
    let id: String
    let username: String
    let coverImage: String?
    let profileImage: String?
    let biography: String?
}

struct EditProfileRequestDTO : Codable, Equatable {
    let id: String
    let username: String
    let coverImage: String?
    let profileImage: String?
    let biography: String?
}

struct ChangeProfilePasswordRequestDTO : Codable, Equatable {
    let oldPassword: String
    let newPassword: String
}

struct FriendProfileResponseDTO : Codable, Equatable {
    let id: String
    let username: String
    let coverImage: String?
    let profileImage: String?
}
