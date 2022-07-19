//
//  FavouriteTracksView.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 11. 10. 2021..
//

import SwiftUI

struct FriendProfileView: View {
    @StateObject private var viewModel = FriendProfileViewModel()
    @Translate private var errorTitle = "Error"
    private var username: String
    
    init(username: String) {
        UITabBar.appearance().unselectedItemTintColor = UIColor(.Mach1Gray)
        UITabBar.appearance().backgroundColor = UIColor(.Mach1Darkest)
        UITabBar.appearance().barTintColor = UIColor(.Mach1Darkest)
        self.username = username
        print("FRIEND \(username)")
    }
    
    var body: some View {
        Mach1View {
            observeUiState.task {
                await viewModel.getProfile(username: username)
                await viewModel.getPlaylists()
                await viewModel.getTracks()
            }
        }
    }
    
    @ViewBuilder
    private var observeUiState: some View {
        switch viewModel.uiState {
        case .Loading:
            Mach1ProgressBar(shape: Circle(), height: Constants.Dimension.progressBar.rawValue, backgroundColor: .clear)
        case .Error(let error):
            Mach1Alert(errorTitle, description: error)
        case .GetFriendProfileSuccess(let profile):
            Mach1BaseFriendProfileView(profile: profile, playlists: [], tracks: [])
        case .GetPlaylistsSuccess(let profile, let playlists):
            Mach1BaseFriendProfileView(profile: profile, playlists: playlists, tracks: [])
        case .GetTracksSuccess(let profile, let playlists, let tracks):
            Mach1BaseFriendProfileView(profile: profile, playlists: playlists, tracks: tracks)
        }
    }
}

struct ProfileFavouriteTracksView_Previews: PreviewProvider {
    static var previews: some View {
        FriendProfileView(username: "Friendly")
    }
}
