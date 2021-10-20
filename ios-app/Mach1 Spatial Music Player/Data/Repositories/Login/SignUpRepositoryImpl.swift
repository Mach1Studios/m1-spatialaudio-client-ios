import Foundation

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
    func signUp(dto: SignUpRequestDTO) async throws -> SignUpResponseDTO {
        throw "Not implemented"
    }
}

actor MockedSignUpRepositoryImpl: SignUpRepository {
    func signUp(dto: SignUpRequestDTO) async throws -> SignUpResponseDTO {
        return try ReadFile.json(resource: .ValidToken)
    }
}
