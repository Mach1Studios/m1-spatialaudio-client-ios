//
//  FavouriteTracksView.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 11. 10. 2021..
//

import SwiftUI

struct ProfileFavouriteTracksView: View {
    @StateObject private var viewModel = ProfileFavouriteTracksViewModel()
    @Translate private var errorTitle = "Error"
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(.Mach1Gray)
        UITabBar.appearance().backgroundColor = UIColor(.Mach1Darkest)
        UITabBar.appearance().barTintColor = UIColor(.Mach1Darkest)
    }
    
    var body: some View {
        Mach1View {
            observeUiState.task {
                await viewModel.get()
            }
        }
    }
    
    @ViewBuilder
    private var observeUiState: some View {
        switch viewModel.uiState {
        case .Loading:
            Mach1ProgressBar(shape: Circle(), height: Constants.Dimension.progressBar, backgroundColor: .clear)
        case .Error(let error):
            Mach1Alert(errorTitle, description: error)
        case .GetSuccess(let profile):
            Mach1BaseProfileFavouriteTracksView(profile: profile)
        }
    }
}

struct ProfileFavouriteTracksView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileFavouriteTracksView()
    }
}
