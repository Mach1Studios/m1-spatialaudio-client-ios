import Foundation

struct SectionedPlaylistResponseDTO: Codable, Equatable {
    let section: String
    let items: [PlaylistItemDTO]
}

struct PlaylistItemDTO: Codable, Equatable {
    let id: UUID
    let title: String
    let url: String?
}

struct PlaylistDTO: Codable, Equatable {
    let id: UUID
    let title: String
    let url: String?
}
