//
//  ProfileViewModel.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 7. 10. 2021..
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.getProfileInfoUseCase) private var getProfileInfoUseCase: GetProfileInfoUseCase
    @Inject(\.logoutUseCase) private var logoutUseCase: LogoutUseCase
    @Published private(set) var uiState: ProfileState = .Loading
    
    func get() async {
        self.uiState = .Loading
        do {
            self.uiState = .Success(try await getProfileInfoUseCase.execute())
        } catch {
            logger.error("Error when get profile info \(error)", LoggerCategoryType.Profile)
            self.uiState = .Error(error.localizedDescription)
        }
    }
    
    func logout() async {
        do {
            try await logoutUseCase.execute()
        } catch {
            logger.error("Error when logout \(error)", LoggerCategoryType.Profile)
            self.uiState = .Error(error.localizedDescription)
        }
    }
}

enum ProfileState {
    case Loading
    case Error(String)
    case Success(Profile)
}
