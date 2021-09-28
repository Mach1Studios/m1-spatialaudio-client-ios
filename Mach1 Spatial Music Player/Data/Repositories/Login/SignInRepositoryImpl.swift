import Foundation

private struct SignInRepositoryKey: InjectionKey {
    static var currentValue: SignInRepository = SignInRepositoryImpl()
}

extension InjectedValues {
    var signInRepository: SignInRepository {
        get { Self[SignInRepositoryKey.self] }
        set { Self[SignInRepositoryKey.self] = newValue }
    }
}

class SignInRepositoryImpl: SignInRepository {
    func signIn(dto: SignInRequestDTO) async throws -> SignInResponseDTO {
        throw "Not implemented"
    }
}

class MockedSignInRepositoryImpl: SignInRepository {
    func signIn(dto: SignInRequestDTO) async throws -> SignInResponseDTO {
        return try ReadFile.json(resource: .ValidToken)
    }
}
