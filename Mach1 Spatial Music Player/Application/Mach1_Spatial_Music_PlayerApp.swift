import SwiftUI

@main
struct Mach1_Spatial_Music_PlayerApp: App {
    init() {
        MockedRepositoryInjectionFactory.setUp()
    }
    var body: some Scene {
        WindowGroup {
            SignInView()
        }
    }
}
