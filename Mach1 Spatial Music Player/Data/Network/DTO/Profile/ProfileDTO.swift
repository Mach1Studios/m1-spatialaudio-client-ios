//
//  ProfileDTO.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 7. 10. 2021..
//

import Foundation

struct ProfileResponseDTO: Codable, Equatable {
    let id: String
    let username: String
    let coverImage: String?
    let profileImage: String?
    let numberOfFriends: Int
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

struct ChangeProfilePasswordRequestDTO: Codable, Equatable {
    let oldPassword: String
    let newPassword: String
}

struct ProfileFavouriteTracksResponseDTO: Codable, Equatable {
    let id: String
    let username: String
    let coverImage: String?
    let profileImage: String?
    let playlists: [PlaylistItemDTO]
}
