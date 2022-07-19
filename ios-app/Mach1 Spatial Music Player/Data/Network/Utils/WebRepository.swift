import Foundation

private struct WebRepositoryKey: InjectionKey {
    static var currentValue: WebRepository = WebRepositoryImpl()
}

extension InjectedValues {
    var webRepository: WebRepository {
        get { Self[WebRepositoryKey.self] }
        set { Self[WebRepositoryKey.self] = newValue }
    }
}

protocol WebRepository {
    var webSession: WebSessionProviding { get }
    var baseUrl: String { get }
}

struct ApiCalls {}

struct WebRepositoryImpl: WebRepository {
//    var path: String
//    var method: MethodType
//    var headers: [String : String]?
//
//    func body() throws -> Data? {
//
//    }
    
    @Inject(\.webSession) internal var webSession: WebSessionProviding
    @config(.apiUrl) var baseUrl: String = ""
    
    subscript(_ req: ApiCall) -> URLRequest? {
        get { try? req.urlRequest(baseUrl) }
    }
}
