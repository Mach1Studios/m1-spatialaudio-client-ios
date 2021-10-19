import os
import Foundation

private struct LoggerFactoryProviderKey: InjectionKey {
    static var currentValue: LoggerFactory = LoggerFactoryImpl()
}

extension InjectedValues {
    var logger: LoggerFactory {
        get { Self[LoggerFactoryProviderKey.self] }
        set { Self[LoggerFactoryProviderKey.self] = newValue }
    }
}

typealias LoggerCategory = String

protocol LoggerFactory {
    func info<T: RawRepresentable>(_ message: String, _ category: T) where T.RawValue == LoggerCategory
    func debug<T: RawRepresentable>(_ message: String, _ category: T) where T.RawValue == LoggerCategory
    func error<T: RawRepresentable>(_ message: String, _ category: T) where T.RawValue == LoggerCategory
}

class LoggerFactoryImpl: LoggerFactory {
    @ConfigurationProperty(key: "App name", defaultValue: "Mach1") var applicationName: String
    @ConfigurationProperty(key: "Is log enabled", defaultValue: false) var isLogEnabled: Bool
    var loggers: [LoggerCategory: Logger] = [:]
    
    func info<T>(_ message: String, _ category: T) where T : RawRepresentable, T.RawValue == LoggerCategory {
        if !isLogEnabled { return }
        find(category.rawValue)
        loggers[category.rawValue]?.info("\(message)")
    }
    
    func debug<T>(_ message: String, _ category: T) where T : RawRepresentable, T.RawValue == LoggerCategory {
        if !isLogEnabled { return }
        find(category.rawValue)
        loggers[category.rawValue]?.debug("\(message)")
    }
    
    func error<T>(_ message: String, _ category: T) where T : RawRepresentable, T.RawValue == LoggerCategory {
        if !isLogEnabled { return }
        find(category.rawValue)
        loggers[category.rawValue]?.error("\(message)")
    }
    
    private func find(_ category: LoggerCategory) {
        if loggers[category] == nil {
            DispatchQueue.main.async { [weak self] in
                self?.loggers[category] = Logger(subsystem: self?.applicationName ?? "", category: category)
            }
        }
    }
}
