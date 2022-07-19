import Foundation

struct SignUpRequestDTO: Codable, Equatable {
    let username: String
    let email: String
    let password: String
}

struct SignUpResponseDTO: Codable, Equatable {
    let id: UUID
    let username: String
    let email: String
    let role: String
    let lastSeen: String
}

//struct SignUpResponseDTO: Decodable {
//    let token: String
//}
