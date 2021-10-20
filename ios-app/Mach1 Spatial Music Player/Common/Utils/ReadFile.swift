import Foundation

class ReadFile {
    static func json<DATA: Decodable>(resource: MockedResource) throws -> DATA {
        do {
            let url = Bundle.main.url(forResource: resource.rawValue, withExtension: "json")
            return try JSONDecoder().decode(DATA.self, from: try Data(contentsOf: url!))
        } catch {
            throw "Cannot read json file: \(resource.rawValue).json Error: \(error)"
        }
    }
}
