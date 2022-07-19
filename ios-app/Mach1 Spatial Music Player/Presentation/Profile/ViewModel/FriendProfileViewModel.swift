//
//  ProfileFavouriteTracks.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 11. 10. 2021..
//

import Foundation
import SwiftUI

class FriendProfileViewModel: ObservableObject {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.getFriendProfileUseCase) private var getFriendProfileUseCase: GetFriendProfileUseCase
    @Inject(\.getPlaylistsForProfileUseCase) private var getPlaylistsForProfileUseCase: GetPlaylistsForProfileUseCase
    @Inject(\.getPlaylistTracksUseCase) private var getPlaylistTracksUseCase: GetPlaylistTracksUseCase
   
    @Published private(set) var uiState: ProfileFavouriteTracksState = .Loading
    @Published private(set) var activePlaylist: SectionedPlaylistItem? = nil
    
    var profile: FriendProfile? = nil
    var playlists: [SectionedPlaylistItem] = []
    var tracks: [Track] = []
    var track: Track? = nil
    var isTrackSelected: Bool = false
    
    @MainActor
    func getProfile(username: String) async {
        self.uiState = .Loading
        do {
            profile = try await getFriendProfileUseCase.execute(username: username)
            self.uiState = .GetFriendProfileSuccess(profile!)
        } catch {
            logger.error("Error when get profile info \(error)", LoggerCategoryType.Profile)
            self.uiState = .Error(error.localizedDescription)
        }
    }
    
    @MainActor
    func getPlaylists() async {
        self.uiState = .Loading
        do {
            if let friend = profile {
                playlists = try await getPlaylistsForProfileUseCase.execute(username: friend.username)
                self.uiState = .GetPlaylistsSuccess(profile!, playlists)
            }
        } catch {
            logger.error("Error when get friends playlists \(error)", LoggerCategoryType.Profile)
            self.uiState = .Error(error.localizedDescription)
        }
    }
    
    @MainActor
    func getTracks() async {
        self.uiState = .Loading
        do {
            if (!playlists.isEmpty) {
                if let playlist = activePlaylist {
                    tracks = try await getPlaylistTracksUseCase.execute(id: playlist.id)
                    self.uiState = .GetTracksSuccess(profile!, playlists, tracks)
                } else {
                    activePlaylist = playlists[0]
                    tracks = try await getPlaylistTracksUseCase.execute(id: activePlaylist!.id)
                    self.uiState = .GetTracksSuccess(profile!, playlists, tracks)
                }
            }
        } catch {
            logger.error("Error when get tracks of friend playlist \(error)", LoggerCategoryType.Profile)
            self.uiState = .Error(error.localizedDescription)
        }
    }
    
    func selectTrack(_ track: Track) {
        self.track = track
        self.isTrackSelected = true
    }
}

enum ProfileFavouriteTracksState {
    case Loading
    case Error(String)
    case GetFriendProfileSuccess(FriendProfile)
    case GetPlaylistsSuccess(FriendProfile, [SectionedPlaylistItem])
    case GetTracksSuccess(FriendProfile, [SectionedPlaylistItem], [Track])
}
