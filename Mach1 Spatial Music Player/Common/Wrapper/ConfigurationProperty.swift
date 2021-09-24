import Foundation

@propertyWrapper struct ConfigurationProperty<TYPE> {
    let key: String
    let defaultValue: TYPE
    var wrappedValue: TYPE { get { ConfigurationProperty.find(key) ?? defaultValue } set {} }
    private static func find(_ wrappedValue: String) -> TYPE? {
        guard let dictionary = Bundle.main.infoDictionary, let value = dictionary[wrappedValue] else { return nil }
        if TYPE.Type.self == Bool.Type.self, let v = value as? String { return Bool(v) as? TYPE }
        if TYPE.Type.self == Int.Type.self, let v = value as? String { return Int(v) as? TYPE }
        return value as? TYPE
    }
}

