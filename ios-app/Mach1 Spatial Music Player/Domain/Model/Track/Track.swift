import Foundation

struct Track {
    let id: UUID
    let name: String
    let description: String
    let url: String?
    
    init(_ dto: TrackDTO) {
        self.id = dto.id
        self.name = dto.name
        self.description = dto.description
        self.url = dto.url
    }
}
