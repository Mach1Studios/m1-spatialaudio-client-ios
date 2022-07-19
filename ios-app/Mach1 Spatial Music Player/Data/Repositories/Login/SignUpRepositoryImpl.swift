import Foundation
import Get

private struct SignUpRepositoryKey: InjectionKey {
    static var currentValue: SignUpRepository = SignUpRepositoryImpl()
}

extension InjectedValues {
    var signUpRepository: SignUpRepository {
        get { Self[SignUpRepositoryKey.self] }
        set { Self[SignUpRepositoryKey.self] = newValue }
    }
}

actor SignUpRepositoryImpl: SignUpRepository {
    @inject(\.apiClient) internal var apiClient: APIClient
    
    func signUp(dto: SignUpRequestDTO) async throws -> SignUpResponseDTO {
        return try await apiClient.send(.post("/register", body: dto)).value
    }
}

actor MockedSignUpRepositoryImpl: SignUpRepository {
    func signUp(dto: SignUpRequestDTO) async throws -> SignUpResponseDTO {
        return try ReadFile.json(resource: .ValidToken)
    }
}
