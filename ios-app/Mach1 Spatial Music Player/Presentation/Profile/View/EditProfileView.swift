//
//  EditProfileView.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 8. 10. 2021..
//

import SwiftUI

struct EditProfileView: View {
    @StateObject private var viewModel = EditProfileViewModel()
    @Translate private var errorTitle = "Error"
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(.Mach1Gray)
        UITabBar.appearance().backgroundColor = UIColor(.Mach1Darkest)
        UITabBar.appearance().barTintColor = UIColor(.Mach1Darkest)
        UITextView.appearance().backgroundColor = UIColor(.Mach1Dark)
    }
    
    var body: some View {
        Mach1View {
            observeUiState.task { await viewModel.get() }
        }
    }
    
    @ViewBuilder
    private var observeUiState: some View {
        switch viewModel.uiState {
            case .Loading:
            Mach1ProgressBar(shape: Circle(), height: Constants.Dimension.progressBar.rawValue, backgroundColor: .clear)
            case .Error(let error):
                Mach1Alert(errorTitle, description: error)
            case .GetSuccess(let profile):
                Mach1BaseEditProfileView(profile: profile)
            case .OnSavingChanges(let profile):
                Mach1BaseEditProfileView(profile: profile, savingChanges: true)
            case .OnSavedSuccess(let profile):
                Mach1BaseEditProfileView(profile: profile, savingChanges: false)
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
