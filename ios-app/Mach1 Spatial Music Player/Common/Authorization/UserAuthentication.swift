import Foundation
import Combine
import KeychainAccess

private struct UserAuthenticationKey: InjectionKey {
    static var currentValue: UserAuthentication = UserAuthenticationImpl()
}

extension InjectedValues {
    var authentication: UserAuthentication {
        get { Self[UserAuthenticationKey.self] }
        set { Self[UserAuthenticationKey.self] = newValue }
    }
}

protocol UserAuthentication {
    var token: String? { get }
    var username: String? { get }
    var password: String? { get }
    var status: UserAuthenticationStatus { get }
    func save(token: String, username: String, password: String)
    func invalidate()
    func forget()
}

enum UserAuthenticationStatus : Equatable {
    case unauthenticated
    case authenticated(_ token: String)
}

fileprivate let key = "TOKEN"

class UserAuthenticationImpl: UserAuthentication {
    @config(.keychainServiceName) var serviceName: String = "com.mach1.spatial-audio-player:default"
    @config(.keychainTokenStoreKey) var tokenKey: String = "access_token"
    @config(.keychainUsernameStoreKey) var usernameKey: String = "username"
    @config(.keychainPasswordStoreKey) var passwordKey: String = "password"
    
    private lazy var keychain: Keychain = Keychain(service: serviceName)
    
    private(set) var token: String? {
        get { keychain[tokenKey]; }
        set { keychain[tokenKey] = newValue; UserDefaults.standard.token = newValue }
    }
    
    private(set) var username: String? {
        get { keychain[usernameKey] }
        set { keychain[usernameKey] = newValue }
    }
    
    private(set) var password: String? {
        get { keychain[passwordKey] }
        set { keychain[passwordKey] = newValue }
    }
    
    public var status: UserAuthenticationStatus {
        get { token != nil ? .authenticated(token!) : .unauthenticated }
    }
    
    func save(token: String, username: String, password: String) {
        self.token = token
        self.username = username
        self.password = password
    }
    
    func invalidate() {
        self.token = nil
    }
    
    func forget() {
        self.invalidate()
        self.username = nil
        self.password = nil
    }
}

extension UserDefaults {
    @objc dynamic var token: String? {
        get { return string(forKey: key) }
        set { set(newValue, forKey: key) }
    }
}
