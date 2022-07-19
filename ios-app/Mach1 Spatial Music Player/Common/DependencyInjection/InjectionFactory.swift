import Foundation

public protocol InjectionKey {
    associatedtype Value
    static var currentValue: Self.Value { get set }
}

struct InjectedValues {
    private static var current = InjectedValues()
    
    static subscript<K>(key: K.Type) -> K.Value where K : InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }
    
    static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}

@propertyWrapper
struct Inject<T> {
    private let keyPath: WritableKeyPath<InjectedValues, T>
    
    var wrappedValue: T {
        get { InjectedValues[keyPath] }
        set { InjectedValues[keyPath] = newValue }
    }
    
    init(_ keyPath: WritableKeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}

typealias inject = Inject

//public protocol Component {
////    associatedtype Providing
////    static var providedInstance: Self.Providing { get }
//    static var singletonInstance: Component { get }
//}

struct Container {
    private static var components: [AnyObject] = []
}

//struct Container {
//    static var singletonInstance: Component {  }
//
//    static var requires: [Component.Type]
//
//    private static var components: [Component] = []
//
//    public indirect enum ComponentType {
//        case container(_ instance: Container)
//
//        static func resolve(_ what: ComponentType) -> Component? {
//            return what.resolve()
//        }
//
//        var resolved: Component? {
//            return Self.container(Container())
//        }
//
////        func resolve() -> Component? {
////            return Container()
////        }
//    }
//}

public struct HashableType<T> : Hashable {
    public static func == (lhs: HashableType, rhs: HashableType) -> Bool {
        return lhs.base == rhs.base
    }
    
    let base: T.Type
    
    init(_ base: T.Type) {
        self.base = base
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(base))
    }
}
