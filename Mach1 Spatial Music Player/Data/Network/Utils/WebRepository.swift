import Foundation

protocol WebRepository {
    var webSession: WebSessionProviding { get }
    var baseUrl: String { get }
}
