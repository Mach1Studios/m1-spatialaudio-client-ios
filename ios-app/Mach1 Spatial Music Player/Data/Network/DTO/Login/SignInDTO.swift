import Foundation

struct SignInRequestDTO: Codable, Equatable {
    let userName: String
    let password: String
}

struct SignInResponseDTO: Codable, Equatable {
    let token: String
}
