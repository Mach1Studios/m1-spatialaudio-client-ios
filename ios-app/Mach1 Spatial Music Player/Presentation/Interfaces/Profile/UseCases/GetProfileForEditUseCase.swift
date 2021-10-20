//
//  GetProfileForEditUseCase.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 8. 10. 2021..
//

import Foundation

protocol GetProfileForEditUseCase {
    func execute() async throws -> ProfileForEdit
}
