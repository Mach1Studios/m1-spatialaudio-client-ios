import Foundation

@propertyWrapper
struct Translate {
    var args: [Any] = []
    var wrappedValue: String {
        didSet { wrappedValue = NSLocalizedString(wrappedValue, comment: "") }
    }
    init(wrappedValue: String) {
        self.wrappedValue = NSLocalizedString(wrappedValue, comment: "")
    }
}

extension String {
    func translate() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
