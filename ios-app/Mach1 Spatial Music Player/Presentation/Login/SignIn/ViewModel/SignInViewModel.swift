import Foundation
import SwiftUI

class SignInViewModel: ObservableObject {
    @inject(\.logger) private var logger: LoggerFactory
    @inject(\.signInUseCase) private var singInUseCase: SignInUseCase
    @inject(\.authentication) private var userAuthentication: UserAuthentication {
        didSet(auth) {
            username = auth.username ?? ""
            password = auth.password ?? ""
        }
    }
    @Published private(set) var uiState: SignInState = .Init
    @Published var username: String = ""
    @Published var password: String = ""
    
    @MainActor
    func signIn() async {
        self.uiState = .Loading
        do {
            try await singInUseCase.execute(params: SignIn.init(username: username, password: password))
        } catch {
            logger.error("Error when sign in: \(error)", LoggerCategoryType.Login)
            self.uiState = .Error(error.localizedDescription)
        }
    }
}

enum SignInState {
    case Init
    case Loading
    case Error(String)
}
