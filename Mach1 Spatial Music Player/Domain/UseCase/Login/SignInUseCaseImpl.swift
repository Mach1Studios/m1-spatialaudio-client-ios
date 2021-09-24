import Foundation

private struct SignInUseCaseKey: InjectionKey {
    static var currentValue: SignInUseCase = SignInUseCaseImpl()
}

extension InjectedValues {
    var signInUseCase: SignInUseCase {
        get { Self[SignInUseCaseKey.self] }
        set { Self[SignInUseCaseKey.self] = newValue }
    }
}

actor SignInUseCaseImpl: SignInUseCase {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.signInRepository) var repository: SignInRepository
    
    func execute(params: SignIn) async throws {
        logger.info("USE CASE: \(type(of: self))", LoggerCategoryType.Login)
        logger.info("Sign in with \(params.username), \(params.password)", LoggerCategoryType.Login)
        let response = try await repository.signIn(dto: SignInRequestDTO(userName: params.username, password: params.password))
        logger.info("Response sign in token \(response.token)", LoggerCategoryType.Login)
        // TODO save to user defaults and update authorization class Token(value: response)
    }
}
