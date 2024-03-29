//
//  GetPlaylistsForProfileUseCase.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 15. 10. 2021..
//

import Foundation

protocol GetPlaylistsForProfileUseCase {
    func execute(username: String) async throws -> [SectionedPlaylistItem]
}
