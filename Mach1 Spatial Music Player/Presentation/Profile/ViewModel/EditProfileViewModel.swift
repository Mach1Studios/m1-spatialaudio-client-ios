//
//  EditProfileViewModel.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 8. 10. 2021..
//

import Foundation
import SwiftUI

class EditProfileViewModel: ObservableObject {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.getProfileForEditUseCase) private var getProfileForEditUseCase: GetProfileForEditUseCase
    @Inject(\.saveProfileChangesUseCase) private var saveProfileChangesUseCase: SaveProfileChangesUseCase
    @Published private(set) var uiState: EditProfileState = .Loading
    
    @Published var username = ""
    @Published var biography = ""
    @Published var coverImage = ""
    @Published var profileImage = ""
    
    @MainActor
    func get() async {
        self.uiState = .Loading
        do {
            self.uiState = .GetSuccess(try await getProfileForEditUseCase.execute())
        } catch {
            logger.error("Error when get profile for edit \(error)", LoggerCategoryType.EditProfile)
            self.uiState = .Error(error.localizedDescription)
        }
    }
    
    @MainActor
    func saveChanges(profile: ProfileForEdit) async {
        self.uiState = .OnSavingChanges(profile)
        do {
            try await self.saveProfileChangesUseCase.execute(params: profile, username: self.username, biography: self.biography, coverImage: self.coverImage, profileImage: self.profileImage)
        } catch {
            logger.error("Error when saving profile changes \(error)", LoggerCategoryType.EditProfile)
            self.uiState = .Error(error.localizedDescription)
        }
        self.uiState = .OnSavedSuccess(profile)
        await self.get()
    }
}

enum EditProfileState {
    case Loading
    case Error(String)
    case GetSuccess(ProfileForEdit)
    case OnSavingChanges(ProfileForEdit)
    case OnSavedSuccess(ProfileForEdit)
}
