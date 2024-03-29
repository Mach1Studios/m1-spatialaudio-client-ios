import Foundation

struct Friend {
    let id: UUID
    let name: String
    let commonFriends: Int
    let image: String?
    
    init(_ dto: FriendDTO) {
        self.id = dto.id
        self.name = dto.username
        self.commonFriends = dto.commonFriends ?? 0
        self.image = dto.image ?? "_"
    }
}
