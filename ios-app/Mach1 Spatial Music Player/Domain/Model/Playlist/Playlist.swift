import Foundation

struct SectionedPlaylist: Codable, Equatable, Mach1Sectioned {
    var id: String { section }
    var name: String { section }
    var sectionItems: [Mach1SectionItem] { items }
    
    let section: String
    let items: [SectionedPlaylistItem]
    
    init(_ dto: SectionedPlaylistResponseDTO) {
        self.section = dto.section
        self.items = dto.items.map{ SectionedPlaylistItem($0) }
    }
}

struct SectionedPlaylistItem: Codable, Equatable, Mach1SectionItem {
    var id: UUID
    let title: String
    let url: String?
    
    init(_ dto: PlaylistItemDTO) {
        self.id = dto.id
        self.title = dto.title
        self.url = dto.url
    }
}

struct Playlist: Codable {
    var id: UUID
    let title: String
    let url: String?
    
    init(_ dto: PlaylistDTO) {
        self.id = dto.id
        self.title = dto.title
        self.url = dto.url
    }
}

