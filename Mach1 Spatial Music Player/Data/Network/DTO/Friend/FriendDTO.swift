import Foundation

struct FriendDTO: Decodable {
    let id: UUID
    let name: String
    let commonFriends: Int
    let image: String?
}
