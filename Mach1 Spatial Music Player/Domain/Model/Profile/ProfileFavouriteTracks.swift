//
//  ProfileFavouriteTracks.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 11. 10. 2021..
//

import Foundation

struct ProfileFavouriteTracks: Codable, Equatable, Mach1FavouriteTracks {    
    
    var id: String { userId }
    var username: String { userLogin }
    var coverImage: String? { userCoverImage }
    var profileImage: String? { userProfileImage }
    var playlists: [SectionedPlaylistItem] { userPlaylists }
    
    let userId: String
    let userLogin: String
    let userCoverImage: String?
    let userProfileImage: String?
    let userPlaylists: [SectionedPlaylistItem]
    
    init(_ dto: ProfileFavouriteTracksResponseDTO) {
        self.userId = dto.id
        self.userLogin = dto.username
        self.userCoverImage = dto.coverImage
        self.userProfileImage = dto.profileImage
        self.userPlaylists = dto.playlists.map { SectionedPlaylistItem($0) }
    }
    
}
