import Foundation

struct PlaylistTracksDTO : Codable, Equatable {
    let id: UUID
    let name: String
    let tracks: [TrackDTO]
}

struct TrackDTO : Codable, Equatable {
    let id: UUID
    let name: String
    let position: Int
    let description: String?
    let url: String?
    
    
}
