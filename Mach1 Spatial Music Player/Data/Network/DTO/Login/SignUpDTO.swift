import Foundation

struct SignUpRequestDTO {
    let username: String
    let email: String
    let password: String
}

struct SignUpResponseDTO {
    let token: String
}
