import Foundation

struct SectionedPlaylistResponseDTO: Codable, Equatable {
    let section: String
    let items: [PlaylistItemDTO]
}

struct PlaylistItemDTO: Codable, Equatable {
    let title: String
    let url: String?
}
