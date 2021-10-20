//
//  GetFriendsUseCase.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 15. 10. 2021..
//

import Foundation

protocol GetFriendsUseCase {
    func execute() async throws -> [Friend]
}
