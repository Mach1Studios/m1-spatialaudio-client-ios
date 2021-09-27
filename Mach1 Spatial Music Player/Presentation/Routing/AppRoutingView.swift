import Foundation

enum Route {
    case Login
    case Home
}

class Routing: ObservableObject {
    @Inject(\.authorization) private var userAuthorization: UserAuthorization
    @Published var route : Route = .Login
    private var observer: NSKeyValueObservation?
    init() {
        self.direct()
        observer = UserDefaults.standard.observe(\.token, options: [.new]) { [weak self] _, _ in self?.direct() }
    }
    deinit { observer?.invalidate() }
    private func direct() {
        DispatchQueue.main.async { [weak self] in
            self?.route = self?.userAuthorization.getStatus() == .UNATHORIZED ? .Login : .Home
        }
    }
}
