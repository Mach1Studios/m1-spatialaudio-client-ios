import Foundation

struct Track {
    let id: UUID
    let name: String
    let description: String
    let position: Int
    let url: String?
    
    init(_ dto: TrackDTO) {
        self.id = dto.id
        self.name = dto.name
        self.description = dto.description ?? "Track description"
        self.position = dto.position
        self.url = dto.url ?? "_"
    }
}

extension Track : Comparable {
    static func < (lhs: Track, rhs: Track) -> Bool {
        return lhs.position < rhs.position
    }
}
