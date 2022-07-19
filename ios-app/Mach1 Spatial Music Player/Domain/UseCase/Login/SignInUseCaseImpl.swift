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
    @inject(\.logger) private var logger: LoggerFactory
    @inject(\.signInRepository) private var repository: SignInRepository
    @inject(\.authentication) private var userAuthentication: UserAuthentication
    
    func execute(params: SignIn) async throws {
        logger.info("USE CASE: \(type(of: self))", LoggerCategoryType.Login)
        userAuthentication.invalidate()
        logger.info("Sign in with \(params.username), \(params.password)", LoggerCategoryType.Login)
        let response = try await repository.signIn(dto: SignInRequestDTO(login: params.username, password: params.password))
        logger.info("Response sign in token \(response.token)", LoggerCategoryType.Login)
        userAuthentication.save(token: response.token, username: params.username, password: params.password)
    }
}
