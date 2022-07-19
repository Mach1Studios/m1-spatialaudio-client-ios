//
//  GetProfileFavouriteTracksUseCase.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 11. 10. 2021..
//

import Foundation

protocol GetFriendProfileUseCase {
    func execute(username: String) async throws -> FriendProfile
}
