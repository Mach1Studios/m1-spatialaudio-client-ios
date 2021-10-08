import Foundation

protocol FriendRepository {
    func find(search: String?) async throws -> [FriendDTO]
}
