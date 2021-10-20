import Foundation

struct UseCase {
    associatedtype Params
    associatedtype Value
    func run(params: Params) async throws -> Value
}
