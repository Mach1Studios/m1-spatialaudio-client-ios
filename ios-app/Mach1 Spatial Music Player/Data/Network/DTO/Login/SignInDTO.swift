import Foundation

struct SignInRequestDTO: Codable, Equatable {
    let login: String
    let password: String
}

struct SignInResponseDTO: Codable, Equatable {
    let token: String
}
