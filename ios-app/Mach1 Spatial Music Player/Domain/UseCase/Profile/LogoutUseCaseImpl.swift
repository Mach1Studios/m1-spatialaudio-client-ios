//
//  LogoutUseCaseImpl.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 8. 10. 2021..
//

import Foundation

private struct LogoutUseCaseKey: InjectionKey {
    static var currentValue: LogoutUseCase = LogoutUseCaseImpl()
}

extension InjectedValues {
    var logoutUseCase: LogoutUseCase {
        get { Self[LogoutUseCaseKey.self] }
        set { Self[LogoutUseCaseKey.self] = newValue }
    }
}

actor LogoutUseCaseImpl: LogoutUseCase {
    @inject(\.logger) private var logger: LoggerFactory
    @inject(\.authentication) private var userAuthentication: UserAuthentication
    
    func execute() async throws {
        logger.info("USE CASE: \(type(of: self))", LoggerCategoryType.Logout)
        userAuthentication.invalidate()
    }
}
