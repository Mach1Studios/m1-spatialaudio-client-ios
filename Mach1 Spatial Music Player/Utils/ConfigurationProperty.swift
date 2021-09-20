import Foundation

@propertyWrapper struct ConfigurationProperty {
    var wrappedValue: String {
        didSet { wrappedValue = ConfigurationProperty.find(wrappedValue) }
    }
    init(wrappedValue: String) {
        self.wrappedValue = ConfigurationProperty.find(wrappedValue)
    }
    private static func find(_ wrappedValue: String) -> String {
        guard let dictionary = Bundle.main.infoDictionary else { return "" }
        guard let value = dictionary[wrappedValue] as? String else { return "" }
        return value.replacingOccurrences(of: "\\", with: "")
    }
}


