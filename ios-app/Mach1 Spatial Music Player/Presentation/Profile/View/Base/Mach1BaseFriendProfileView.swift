//
//  Mach1BaseProfileFavouriteTracksView.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 11. 10. 2021..
//

import SwiftUI

struct Mach1BaseFriendProfileView: View {
    
    let profile: FriendProfile
    let playlists: [SectionedPlaylistItem]
    let tracks: [Track]
    
    @StateObject private var viewModel = FriendProfileViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Mach1ProfileHeaderView<FriendProfile>(profile: profile, isRoot: false, isEditable: false, title: profile.username, geometry: geometry)
                VStack {
                    HStack {
                        Text("Playlists").textStyle(TitleStyle())
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .leading).padding(.horizontal)
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(playlists, id: \.title) { playlist in
                                Mach1CardImage(title: playlist.title, url: URL(string: playlist.url ?? ""), height: Constants.Image.Dimension.Big, defaultImage: Constants.Image.Default.PlayList, action: {print("Playlist \(playlist.title)")}).frame(width: Constants.Image.Dimension.Bigger.rawValue)
                            }
                        }
                    }.frame(height: Constants.Image.Dimension.Big.rawValue).padding(.horizontal)
                    HStack {
                        Text("Tracks").textStyle(TitleStyle())
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .leading).padding()
                    List {
                        ForEach(tracks, id: \.id) { TrackItemView(track: $0) { track in self.viewModel.selectTrack(track)
                        }}
                        .listRowBackground(Color.Mach1Darkest)
                    }.offset(y: -20).padding(.bottom, -20)
                }.offset(y: -100).padding(.bottom, -100)
            }
        }
    }
}

struct Mach1BaseFriendProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            Mach1BaseFriendProfileView(profile: FriendProfile(FriendProfileResponseDTO(id: "aee63c09-e728-4fc3-afba-dacdbd9a3466", username: "Friend1", coverImage: nil, profileImage: nil)), playlists: [], tracks: [])
        }
    }
}
