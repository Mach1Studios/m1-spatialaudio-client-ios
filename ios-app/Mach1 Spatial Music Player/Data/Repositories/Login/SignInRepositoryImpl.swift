import Foundation
import Get

private struct SignInRepositoryKey: InjectionKey {
    static var currentValue: SignInRepository = SignInRepositoryImpl()
}

extension InjectedValues {
    var signInRepository: SignInRepository {
        get { Self[SignInRepositoryKey.self] }
        set { Self[SignInRepositoryKey.self] = newValue }
    }
}

actor SignInRepositoryImpl: SignInRepository {
    @inject(\.apiClient) internal var apiClient: APIClient
    
    func signIn(dto: SignInRequestDTO) async throws -> SignInResponseDTO {
        return try await apiClient.send(.post("/auth", body: dto)).value
    }
}

actor MockedSignInRepositoryImpl: SignInRepository {
    func signIn(dto: SignInRequestDTO) async throws -> SignInResponseDTO {
        return try ReadFile.json(resource: .ValidToken)
    }
}
