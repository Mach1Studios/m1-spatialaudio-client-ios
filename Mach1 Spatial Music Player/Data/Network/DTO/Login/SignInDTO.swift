import Foundation

struct SignInRequestDTO {
    let userName: String
    let password: String
}

struct SignInResponseDTO {
    let token: String
}
