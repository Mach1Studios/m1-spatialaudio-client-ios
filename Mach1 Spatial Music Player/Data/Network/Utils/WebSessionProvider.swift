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
    var userAuthorization: UserAuthorization { get }
    func configured() -> URLSession
}

struct WebSessionProvider: WebSessionProviding {
    @Inject(\.authorization) internal var userAuthorization: UserAuthorization
    @ConfigurationProperty(key: "Time out request", defaultValue: 15) var timeOutRequest: Int
    @ConfigurationProperty(key: "Time out resource", defaultValue: 120) var timeOutResource: Int
    @ConfigurationProperty(key: "Max http connection per host", defaultValue: 5) var maxHttpConnectionPerHost: Int
    @ConfigurationProperty(key: "Is request cache enabled", defaultValue: false) var isRequestCacheEnabled: Bool
    
    func configured() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(timeOutRequest)
        configuration.timeoutIntervalForResource = TimeInterval(timeOutResource)
        configuration.httpAdditionalHeaders = getHeaders()
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = Int(maxHttpConnectionPerHost)
        if (isRequestCacheEnabled) {
            // HEADER: "Cache-Control max-age: 60"
            configuration.requestCachePolicy = .returnCacheDataElseLoad
            configuration.urlCache = .shared
        } else {
            configuration.urlCache = nil
        }
        return URLSession(configuration: configuration)
    }
    
    private func getHeaders() -> [AnyHashable : Any] {
        switch userAuthorization.getStatus() {
        case .AUTHORIZED:
            return ["Authorization": "Bearer \(String(describing: userAuthorization.getToken()))"]
        default:
            return [:]
        }
    }
}
