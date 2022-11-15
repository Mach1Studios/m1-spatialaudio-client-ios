//
//  APIClientConfiguration.swift
//  Mach1 Spatial Music Player
//
//  Created by Feđa Tica on 17-Apr-22.
//

import Foundation
import Get

private struct APIClientKey : InjectionKey {
    static var currentValue: APIClient = APIClient(baseURL: URL(string: "http://3.139.251.176/api")) {
        $0.delegate = Mach1APIClientDelegate()
    }
}

extension InjectedValues {
    var apiClient: APIClient {
        get { Self[APIClientKey.self] }
        set { Self[APIClientKey.self] = newValue }
    }
}

final class Mach1APIClientDelegate : APIClientDelegate {
    @inject(\.authentication) internal var userAuthentication: UserAuthentication
        
    func client(_ client: APIClient, willSendRequest request: inout URLRequest) async throws {
        request.setValue("Bearer \(userAuthentication.token ?? "")", forHTTPHeaderField: "Authorization")
    }
    
    func shouldClientRetry(_ client: APIClient, for request: URLRequest, withError error: Error) async throws -> Bool {
        if case .unacceptableStatusCode(let status) = (error as? APIError),
           status == 401 {
            return await refreshAccessToken()
        }
        if case .unacceptableStatusCode(let status) = (error as? APIError),
           status == 403 {
            return await refreshAccessToken()
        }
        
        
        return false
    }
    
    private func refreshAccessToken() async -> Bool {
        userAuthentication.invalidate()
        return true
    }
}

extension APIClient {

}
