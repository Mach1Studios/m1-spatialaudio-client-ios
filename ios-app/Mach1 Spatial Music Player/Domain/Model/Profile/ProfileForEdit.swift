//
//  EditProfile.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 8. 10. 2021..
//

import Foundation

struct ProfileForEdit: Codable, Equatable, Mach1EditProfile {
    
    var id: String { userId }
    var username: String { userLogin }
    var coverImage: String? { userCoverImage }
    var profileImage: String? { userProfileImage }
    var biography: String? { userBiography }
    
    let userId: String
    let userLogin: String
    let userCoverImage: String?
    let userProfileImage: String?
    let userBiography: String?
    
    init(_ dto: ProfileForEditResponseDTO) {
        self.userId = dto.id
        self.userLogin = dto.username
        self.userCoverImage = dto.coverImage ?? "_"
        self.userProfileImage = dto.profileImage ?? "_"
        self.userBiography = dto.biography
    }
}
