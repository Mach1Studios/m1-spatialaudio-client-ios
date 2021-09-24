import Foundation

class MockedRepositoryInjectionFactory {
    private init() {}
    static func setUp() {
        @ConfigurationProperty(key: "Need mocked repositories", defaultValue: false) var needMockedRepo: Bool
        if !needMockedRepo { return }
        InjectedValues[\.signInRepository] = MockedSignInRepositoryImpl()
    }
}
