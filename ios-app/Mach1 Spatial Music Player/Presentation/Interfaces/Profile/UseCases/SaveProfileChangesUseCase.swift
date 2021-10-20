//
//  SaveProfileChangesUseCase.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 8. 10. 2021..
//

import Foundation

protocol SaveProfileChangesUseCase {
    func execute(params: ProfileForEdit, username: String, biography: String, coverImage: String, profileImage: String) async throws -> Void
}
