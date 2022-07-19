import Foundation

class MockedRepositoryInjectionFactory {
    private init() {}
    static func setUp() {
        @config(.enableMockedRepositories) var needMockedRepo: Bool = false
        if !needMockedRepo { return }
        InjectedValues[\.signInRepository] = MockedSignInRepositoryImpl()
        InjectedValues[\.signUpRepository] = MockedSignUpRepositoryImpl()
        InjectedValues[\.sectionedPlaylistRepository] = MockedSectionedPlaylistRepositoryImpl()
        InjectedValues[\.profileRepository] = MockedProfileRepositoryImpl()
        InjectedValues[\.playlistDetailsRepository] = MockedPlaylistDetailsRepositoryImpl()
        InjectedValues[\.tracksRepository] = MockedTracksRepositoryImpl()
        InjectedValues[\.friendRepository] = MockedFriendRepositoryImpl()
    }
}
