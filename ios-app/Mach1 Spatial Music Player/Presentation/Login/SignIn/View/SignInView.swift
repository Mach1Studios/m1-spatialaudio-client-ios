import SwiftUI

struct SignInView: View {
    @StateObject private var viewModel = SignInViewModel()
    @Translate private var signUp = "Sign up"
    @Translate private var loginPlaceholder = "Login"
    @Translate private var usernamePlaceHolder = "Insert username"
    @Translate private var passwordPlaceholder = "Insert password"
    @Translate private var errorTitle = "Error"
    @State private var goToSignUp: Bool = false
    
    var body: some View {
        Mach1View {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        Mach1Logo(dimension: .Big).padding(.bottom)
                        Mach1TextField(text: $viewModel.username, placeHolder: usernamePlaceHolder)
                        Mach1TextField(text: $viewModel.password, placeHolder: passwordPlaceholder)
                        Button(loginPlaceholder) { Task.init(priority: .high) { await viewModel.signIn() } }
                        .disabled(viewModel.username.isEmpty || viewModel.password.isEmpty)
                        .buttonStyle(Mach1ButtonStyle())
                        .padding(.top, Mach1Margin.Big.rawValue)
                        Button { goToSignUp.toggle() } label: { Text(signUp.uppercased()).textStyle(BodyStyle()) }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    }.padding()
                        .frame(width: geometry.size.width)
                        .frame(minHeight: geometry.size.height)
                }
            }
            observeUiState
        }
        .sheet(isPresented: $goToSignUp) { SignUpView() }
    }
    
    @ViewBuilder
    private var observeUiState: some View {
        switch viewModel.uiState {
        case .Init:
            EmptyView()
        case .Loading:
            Mach1ProgressBar(shape: Circle(), height: Constants.Dimension.progressBar.rawValue, backgroundColor: .clear)
        case .Error(let error):
            Mach1Alert(errorTitle, description: error)
        }
    }
}

// MARK: Preview

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
