//
//  Profile.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 7. 10. 2021..
//

import Foundation

struct Profile: Codable, Equatable, Mach1Profile {
    var id: String { userId }
    var username: String { userLogin }
    var coverImage: String? { userCoverImage }
    var profileImage: String? { userProfileImage }
    var numberOfFriends: Int { userNumberOfFriends }
    
    let userId: String
    let userLogin: String
    let userCoverImage: String?
    let userProfileImage: String?
    let userNumberOfFriends: Int
    
    init(_ dto: ProfileResponseDTO) {
        self.userId = dto.id
        self.userLogin = dto.username
        self.userCoverImage = dto.coverImage ?? "_"
        self.userProfileImage = dto.profileImage ?? "_"
        self.userNumberOfFriends = dto.numberOfFriends ?? 0
    }
}
