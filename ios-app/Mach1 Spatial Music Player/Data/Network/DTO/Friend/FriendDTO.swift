import Foundation

struct FriendDTO : Codable, Equatable {
    let id: UUID
    let username: String
    let commonFriends: Int?
    let image: String?
}
