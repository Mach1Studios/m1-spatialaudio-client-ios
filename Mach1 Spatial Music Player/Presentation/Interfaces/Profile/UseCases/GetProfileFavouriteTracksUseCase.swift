//
//  GetProfileFavouriteTracksUseCase.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 11. 10. 2021..
//

import Foundation

protocol GetProfileFavouriteTracksUseCase {
    func execute() async throws -> ProfileFavouriteTracks
}
