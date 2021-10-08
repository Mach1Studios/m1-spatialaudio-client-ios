import Foundation

protocol FindFriendUseCase {
    func execute(search: String?) async throws -> [Friend]
}
