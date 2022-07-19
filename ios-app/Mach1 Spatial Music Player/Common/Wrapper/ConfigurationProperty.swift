import Foundation

@propertyWrapper
struct ConfigurationProperty<T> {
    let key: ConfigurationKey
    let defaultValue: T
    var wrappedValue: T {
        get {
            key.asType() ?? defaultValue
        }
    }
    
    init(wrappedValue: T, _ key: ConfigurationKey) {
        self.init(key, defaultValue: wrappedValue)
    }
    
    init(_ key: ConfigurationKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
//    private static func find(_ wrappedValue: String) -> T? {
//        guard let dictionary = Bundle.main.infoDictionary, let value = dictionary[wrappedValue] else { return nil }
//        if T.Type.self == Bool.Type.self, let v = value as? String { return Bool(v) as? T }
//        if T.Type.self == Int.Type.self, let v = value as? String { return Int(v) as? T }
//        return value as? T
//    }
}

typealias config = ConfigurationProperty

enum ConfigurationKey: String {
    private static let dictionary: [String: Any] = Bundle.main.infoDictionary ?? [:]
    
    public var value: Any? {
        get { return Self.dictionary[rawValue] }
    }
    
    public func asType<T>() -> T? {
        if T.Type.self == Bool.Type.self, let v = value as? String { return Bool(v) as? T }
        if T.Type.self == Int.Type.self, let v = value as? String { return Int(v) as? T }
        
        return value as? T
    }
    
    case appName = "App name"
    case enableLogging = "Enable logging"
    case enableRequestCache = "Enable request cache"
    case enableMockedRepositories = "Enable mocked repositories"
    case apiUrl = "Mach1 API URL"
    case maxHttpConnections = "Max HTTP connections per host"
    case requestTimeout = "Request timeout"
    case resourceTimeout = "Resource timeout"
    case keychainServiceName = "Keychain service name"
    case keychainTokenStoreKey = "Keychain token store key"
    case keychainUsernameStoreKey = "Keychain username store key"
    case keychainPasswordStoreKey = "Keychain password store key"
}
