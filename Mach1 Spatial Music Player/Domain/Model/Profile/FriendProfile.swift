//
//  ProfileFavouriteTracks.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 11. 10. 2021..
//

import Foundation

struct FriendProfile: Codable, Equatable, Mach1BaseProfile {
    
    var id: String { userId }
    var username: String { userLogin }
    var coverImage: String? { userCoverImage }
    var profileImage: String? { userProfileImage }
    
    let userId: String
    let userLogin: String
    let userCoverImage: String?
    let userProfileImage: String?
    
    init(_ dto: FriendProfileResponseDTO) {
        self.userId = dto.id
        self.userLogin = dto.username
        self.userCoverImage = dto.coverImage
        self.userProfileImage = dto.profileImage
    }
    
}
