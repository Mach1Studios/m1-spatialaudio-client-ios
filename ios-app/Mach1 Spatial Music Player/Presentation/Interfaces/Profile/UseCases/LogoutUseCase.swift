//
//  LogoutUseCase.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 8. 10. 2021..
//

import Foundation

protocol LogoutUseCase {
    func execute() async throws -> Void
}
