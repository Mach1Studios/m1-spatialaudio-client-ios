import Foundation

private struct WebSessionProviderKey: InjectionKey {
    static var currentValue: WebSessionProviding = WebSessionProvider()
}

extension InjectedValues {
    var webSession: WebSessionProviding {
        get { Self[WebSessionProviderKey.self] }
        set { Self[WebSessionProviderKey.self] = newValue }
    }
}

protocol WebSessionProviding {
    var userAuthentication: UserAuthentication { get }
    func configured() -> URLSession
}

struct WebSessionProvider: WebSessionProviding {
    @Inject(\.authentication) internal var userAuthentication: UserAuthentication
    @config(.requestTimeout) var requestTimeout: Int = 15
    @config(.resourceTimeout) var resourceTimeout: Int = 120
    @config(.maxHttpConnections) var maxHttpConnectionPerHost: Int = 5
    @config(.enableRequestCache) var enableRequestCache: Bool = false
    
    private var headers: [String : String] {
        get {
            switch userAuthentication.status {
            case .authenticated:
                return ["Authorization": "Bearer \(String(describing: userAuthentication.token))"]
            default:
                return [:]
            }
        }
    }
    
    func configured() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(requestTimeout)
        configuration.timeoutIntervalForResource = TimeInterval(resourceTimeout)
        configuration.httpAdditionalHeaders = self.headers
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = Int(maxHttpConnectionPerHost)
        if (enableRequestCache) {
            // HEADER: "Cache-Control max-age: 60"
            configuration.requestCachePolicy = .returnCacheDataElseLoad
            configuration.urlCache = .shared
        } else {
            configuration.urlCache = nil
        }
        return URLSession(configuration: configuration)
    }
    
}
