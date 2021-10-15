//
//  Mach1FavouriteTracks.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 8. 10. 2021..
//

import Foundation

protocol Mach1FavouriteTracks: Mach1BaseProfile {
    var playlists: [SectionedPlaylistItem] { get }
    //TODO: dodati tracks
}
