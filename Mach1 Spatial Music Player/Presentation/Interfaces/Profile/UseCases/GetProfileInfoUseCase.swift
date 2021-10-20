//
//  ProfileUseCase.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 7. 10. 2021..
//

import Foundation

protocol GetProfileInfoUseCase {
    func execute() async throws -> Profile
}
