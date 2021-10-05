import Foundation

struct TrackDTO: Decodable {
    let id: UUID
    let name: String
    let description: String
    let url: String?
}
