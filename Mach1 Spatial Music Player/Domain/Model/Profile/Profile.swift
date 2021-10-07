//
//  Profile.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 7. 10. 2021..
//

import Foundation

struct Profile: Codable, Equatable, Identifiable {
    let id: String
    var username: String
    var biography: String?
    var coverImage: String?
    var profileImage: String?
    var numberOfFriends: Int = 0
}
