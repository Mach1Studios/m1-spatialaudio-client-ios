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
    @Inject(\.authorization) var userAuthorization: UserAuthorization
    @ConfigurationProperty var timeOutRequest: String = "Time out request"
    @ConfigurationProperty var timeOutResource: String = "Time out resource"
    @ConfigurationProperty var maxHttpConnectionPerHost: String = "Max http connection per host"
    @ConfigurationProperty var isRequestCacheEnabled: String = "Is request cache enabled"
    
    func configured() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(timeOutRequest) ?? 15
        configuration.timeoutIntervalForResource = TimeInterval(timeOutResource) ?? 120
        configuration.httpAdditionalHeaders = getHeaders()
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = Int(maxHttpConnectionPerHost) ?? 5
        if (Bool(isRequestCacheEnabled) ?? false) {
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
