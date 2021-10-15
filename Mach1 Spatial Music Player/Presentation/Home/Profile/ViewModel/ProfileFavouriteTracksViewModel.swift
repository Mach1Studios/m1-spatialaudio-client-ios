//
//  ProfileFavouriteTracks.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 11. 10. 2021..
//

import Foundation
import SwiftUI

class ProfileFavouriteTracksViewModel: ObservableObject {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.getProfileFavouriteTracksUseCase) private var getProfileFavouriteTracksUseCase: GetProfileFavouriteTracksUseCase
    @Inject(\.logoutUseCase) private var logoutUseCase: LogoutUseCase
    @Published private(set) var uiState: ProfileFavouriteTracksState = .Loading
    
    @MainActor
    func get() async {
        self.uiState = .Loading
        do {
            self.uiState = .GetSuccess(try await getProfileFavouriteTracksUseCase.execute())
        } catch {
            logger.error("Error when get profile info \(error)", LoggerCategoryType.Profile)
            self.uiState = .Error(error.localizedDescription)
        }
    }
    
    @MainActor
    func logout() async {
        do {
         try await logoutUseCase.execute()
        } catch {
            logger.error("Error when logout \(error)", LoggerCategoryType.Profile)
            self.uiState = .Error(error.localizedDescription)
        }
    }
}

enum ProfileFavouriteTracksState {
    case Loading
    case Error(String)
    case GetSuccess(ProfileFavouriteTracks)
}
