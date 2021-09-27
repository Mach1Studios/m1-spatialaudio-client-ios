import Foundation

private struct UserAuthorizationKey: InjectionKey {
    static var currentValue: UserAuthorization = UserAuthorizationImpl()
}

extension InjectedValues {
    var authorization: UserAuthorization {
        get { Self[UserAuthorizationKey.self] }
        set { Self[UserAuthorizationKey.self] = newValue }
    }
}

protocol UserAuthorization {
    func getStatus() -> UserAuthorizationStatus
    func getToken() -> String?
    func save(token: String)
    func invalidate()
}

enum UserAuthorizationStatus {
    case AUTHORIZED
    case UNATHORIZED
}

fileprivate let key = "TOKEN"

class UserAuthorizationImpl: UserAuthorization {
    func getStatus() -> UserAuthorizationStatus {
        guard getToken() != nil else { return .UNATHORIZED }
        return .AUTHORIZED
    }
    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    func save(token: String) {
        UserDefaults.standard.token = token
    }
    func invalidate() {
        UserDefaults.standard.token = nil
    }
}

extension UserDefaults {
    @objc dynamic var token: String? {
        get { return string(forKey: key) }
        set { set(newValue, forKey: key) }
    }
}
