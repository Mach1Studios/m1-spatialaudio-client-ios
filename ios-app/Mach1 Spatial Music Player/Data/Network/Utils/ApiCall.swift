import Foundation

protocol ApiCall {
    var path: String { get }
    var method: MethodType { get }
    var headers: [String: String]? { get }
    func body() throws -> Data?
}

extension ApiCall {
    func urlRequest(_ baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else { throw ApiError.invalidURL }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}

enum ApiError: Swift.Error {
    case invalidURL
    case unexpectedResponse
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL".translate()
        case .unexpectedResponse: return "Unexpected response from the server".translate()
        }
    }
}

enum MethodType: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
}
