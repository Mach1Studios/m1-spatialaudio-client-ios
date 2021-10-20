//
//  GetProfileForEditUseCaseImpl.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 8. 10. 2021..
//

import Foundation

private struct GetProfileForEditUseCaseKey: InjectionKey {
    static var currentValue: GetProfileForEditUseCase = GetProfileForEditUseCaseImpl()
}

extension InjectedValues {
    var getProfileForEditUseCase: GetProfileForEditUseCase {
        get { Self[GetProfileForEditUseCaseKey.self] }
        set { Self[GetProfileForEditUseCaseKey.self] = newValue }
    }
}

actor GetProfileForEditUseCaseImpl: GetProfileForEditUseCase {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.profileRepository) private var repository: ProfileRepository
    
    func execute() async throws -> ProfileForEdit {
        logger.info("USE CASE: \(type(of: self))", LoggerCategoryType.EditProfile)
        let response = try await repository.getProfileForEdit()
        logger.info("Response get profile for edit: \(response)", LoggerCategoryType.EditProfile)
        return ProfileForEdit(response)
    }
}
