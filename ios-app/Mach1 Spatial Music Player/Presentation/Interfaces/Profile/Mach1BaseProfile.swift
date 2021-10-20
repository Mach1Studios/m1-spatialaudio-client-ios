//
//  Mach1BaseProfile.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 8. 10. 2021..
//

import Foundation

protocol Mach1BaseProfile: Identifiable {
    var username: String { get }
    var coverImage: String? { get }
    var profileImage: String? { get }
}
