import Foundation

struct SectionedPlaylistResponseDTO : Codable, Equatable {
    let section: String
    let items: [PlaylistItemDTO]
}

struct PlaylistItemDTO : Codable, Equatable {
    let id: UUID
    let name: String
    let url: String?
}

struct UserPlaylistsDTO : Codable, Equatable {
    let playlists: [PlaylistItemDTO]
}

struct PlaylistDTO : Codable, Equatable {
    let id: UUID
    let name: String
    let isPublic: Bool?
    let owner: PlaylistOwnerDTO?
    let tracks: [PlaylistTrackDTO]?
    let url: String?
}

struct PlaylistOwnerDTO : Codable, Equatable {
    let id: UUID?
    let username: String?
}

struct PlaylistTrackDTO : Codable, Equatable {
    let id: UUID
    let name: String
    let position: Int
}
