//
//  Mach1BaseProfileFavouriteTracksView.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 11. 10. 2021..
//

import SwiftUI

struct Mach1BaseProfileFavouriteTracksView: View {
    
    let profile: ProfileFavouriteTracks
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Mach1ProfileHeaderView<ProfileFavouriteTracks>(profile: profile, isRoot: false, isEditable: false, title: profile.username, geometry: geometry)
                VStack {
                    HStack {
                        Text("Playlists").textStyle(TitleStyle())
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .leading).padding(.horizontal)
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(profile.playlists, id: \.title) { playlist in
                                Mach1CardImage(title: playlist.title, url: URL(string: playlist.url ?? ""), height: Constants.Image.Dimension.Big, defaultImage: Constants.Image.Default.PlayList, action: {print("Playlist \(playlist.title)")}).frame(width: Constants.Image.Dimension.Bigger.rawValue)
                            }
                        }
                    }.frame(height: Constants.Image.Dimension.Big.rawValue).padding(.horizontal)
                    HStack {
                        Text("Tracks").textStyle(TitleStyle())
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .leading).padding()
                }.offset(y: -100).padding(.bottom, -100)
            }
        }
    }
}

struct Mach1BaseProfileFavouriteTracksView_Previews: PreviewProvider {
    private static var profile: ProfileFavouriteTracks {
        var favouriteTracks = ProfileFavouriteTracks(ProfileFavouriteTracksResponseDTO(id: "4d9eff5f-2d95-4994-82f2-caf3959be2c8", username: "John Doe", coverImage: nil, profileImage: nil, playlists: []))
        do {
            favouriteTracks = try ProfileFavouriteTracks(ReadFile.json(resource: .ProfileFavouriteTracks))
        } catch {
            print(error)
        }
        return favouriteTracks
    }
    static var previews: some View {
        Mach1View {
            Mach1BaseProfileFavouriteTracksView(profile: profile)
        }
    }
}
