import Foundation

protocol SignUpUseCase {
    func execute(params: SignUp) async throws
}
