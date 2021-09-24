import Foundation

protocol SignInUseCase {
    func execute(params: SignIn) async throws
}


