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
    private var friendId: UUID
    
    init(friendId: UUID) {
        UITabBar.appearance().unselectedItemTintColor = UIColor(.Mach1Gray)
        UITabBar.appearance().backgroundColor = UIColor(.Mach1Darkest)
        UITabBar.appearance().barTintColor = UIColor(.Mach1Darkest)
        self.friendId = friendId
        print("FRIEND \(friendId)")
    }
    
    var body: some View {
        Mach1View {
            observeUiState.task {
                await viewModel.getProfile(id: friendId)
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
        FriendProfileView(friendId: UUID.init(uuidString: "4d9eff5f-2d95-4994-82f2-caf3959be2c8")!)
    }
}
