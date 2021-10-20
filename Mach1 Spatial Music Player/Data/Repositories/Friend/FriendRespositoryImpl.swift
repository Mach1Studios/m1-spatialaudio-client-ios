import Foundation

private struct FriendRepositoryKey: InjectionKey {
    static var currentValue: FriendRepository = FriendRepositoryImpl()
}

extension InjectedValues {
    var friendRepository: FriendRepository {
        get { Self[FriendRepositoryKey.self] }
        set { Self[FriendRepositoryKey.self] = newValue }
    }
}

actor FriendRepositoryImpl: FriendRepository {
    func getFriends() async throws -> [FriendDTO] {
        throw "Not implemented"
    }
    
    func find(search: String?) async throws -> [FriendDTO] {
        throw "Not implemented"
    }
}

actor MockedFriendRepositoryImpl: FriendRepository {
    func getFriends() async throws -> [FriendDTO] {
        return try ReadFile.json(resource: .Friends)
    }
    
    func find(search: String?) async throws -> [FriendDTO] {
        let friends: [FriendDTO] = try ReadFile.json(resource: .Friends)
        guard let searchText = search, !searchText.isEmpty else { return friends }
        return friends.filter { $0.name.contains(searchText) }
    }
}

