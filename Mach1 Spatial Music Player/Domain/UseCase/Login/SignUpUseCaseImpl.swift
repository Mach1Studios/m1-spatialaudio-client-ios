import Foundation

private struct SignUpUseCaseKey: InjectionKey {
    static var currentValue: SignUpUseCase = SignUpUseCaseImpl()
}

extension InjectedValues {
    var signUpUseCase: SignUpUseCase {
        get { Self[SignUpUseCaseKey.self] }
        set { Self[SignUpUseCaseKey.self] = newValue }
    }
}

actor SignUpUseCaseImpl: SignUpUseCase {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.signUpRepository) private var repository: SignUpRepository
    @Inject(\.authorization) private var userAuthorization: UserAuthorization

    func execute(params: SignUp) async throws {
        logger.info("USE CASE: \(type(of: self))", LoggerCategoryType.Login)
        logger.info("Sign up with \(params.username), \(params.email), \(params.password)", LoggerCategoryType.Login)
        let response = try await repository.signUp(dto: SignUpRequestDTO(username: params.username, email: params.email, password: params.password))
        logger.info("Response sign up token \(response.token)", LoggerCategoryType.Login)
        userAuthorization.save(token: response.token)
    }
}
