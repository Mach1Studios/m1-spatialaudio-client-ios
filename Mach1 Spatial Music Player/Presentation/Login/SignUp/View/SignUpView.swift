import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    @Translate private var usernamePlaceHolder = "Insert username"
    @Translate private var emailPlaceHolder = "Insert email"
    @Translate private var passwordPlaceholder = "Insert password"
    @Translate private var registerPlaceHolder = "Register"
    @Translate private var errorTitle = "Error"
    
    var body: some View {
        Mach1View {
            VStack {
                Text(registerPlaceHolder.uppercased())
                    .foregroundColor(Color.Mach1Yellow).textStyle(TitleStyle())
                    .padding(.top, Mach1Margin.VBig.rawValue)
                Mach1TextField(text: $viewModel.username, placeHolder: usernamePlaceHolder)
                    .padding(.top, Mach1Margin.VBig.rawValue)
                Mach1TextField(text: $viewModel.email, placeHolder: emailPlaceHolder)
                Mach1TextField(text: $viewModel.password, placeHolder: passwordPlaceholder)
                Button(registerPlaceHolder) { Task.init(priority: .high) { await viewModel.signUp() } }
                .disabled(viewModel.username.isEmpty || viewModel.email.isEmpty || viewModel.password.isEmpty)
                .buttonStyle(Mach1ButtonStyle())
                .padding(.top, Mach1Margin.Big.rawValue)
                Spacer()
            }.padding()
            observeUiState
        }
    }
    
    @ViewBuilder
    private var observeUiState: some View {
        switch viewModel.uiState {
        case .Init:
            EmptyView()
        case .Loading:
            Mach1ProgressBar(shape: Circle(), height: Constants.Dimension.progressBar, backgroundColor: .clear)
        case .Error(let error):
            Mach1Alert(errorTitle, description: error)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
