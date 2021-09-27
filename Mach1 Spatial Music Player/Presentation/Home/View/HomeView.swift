import SwiftUI

struct HomeView: View {
    @Inject(\.authorization) private var authorization: UserAuthorization
    var body: some View {
        Mach1View {
            Button { authorization.invalidate() } label: {Text("Logout") }
        }
    }
}

// MARK: Preview

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
