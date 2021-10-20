import Foundation
import SwiftUI

class SignUpViewModel: ObservableObject {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.signUpUseCase) private var singUpUseCase: SignUpUseCase
    @Published private(set) var uiState: SignUpState = .Init
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    @MainActor
    func signUp() async {
        self.uiState = .Loading
        do {
            try await singUpUseCase.execute(params: SignUp.init(username: username, email: email, password: password))
        } catch {
            logger.error("Error when sign in: \(error)", LoggerCategoryType.Login)
            self.uiState = .Error(error.localizedDescription)
        }
    }
}

enum SignUpState {
    case Init
    case Loading
    case Error(String)
}
