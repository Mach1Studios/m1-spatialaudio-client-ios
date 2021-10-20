//
//  ProfileView.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 8. 10. 2021..
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @Translate private var errorTitle = "Error"
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(.Mach1Gray)
        UITabBar.appearance().backgroundColor = UIColor(.Mach1Darkest)
        UITabBar.appearance().barTintColor = UIColor(.Mach1Darkest)
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
        case .Success(let profile):
            Mach1BaseProfileView(profile: profile)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
