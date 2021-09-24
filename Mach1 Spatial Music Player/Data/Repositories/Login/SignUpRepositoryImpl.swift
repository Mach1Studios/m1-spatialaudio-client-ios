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

class SignUpRepositoryImpl: SignUpRepository {
    func signUp(dto: SignUpRequestDTO) async throws -> SignUpResponseDTO {
        throw "Not implemented"
    }
}

class MockedSignUpRepositoryImpl: SignUpRepository {
    func signUp(dto: SignUpRequestDTO) async throws -> SignUpResponseDTO {
        throw "Mocked sign up repository"
    }
}
