import SwiftUI

@main
struct Mach1_Spatial_Music_PlayerApp: App {
    @StateObject var routing = Routing()
    init() {
        MockedRepositoryInjectionFactory.setUp()
    }
    var body: some Scene {
        WindowGroup {
            switch(routing.route) {
            case .Login:
                SignInView()
            case .Home:
                HomeView()
            }
        }
    }
}
