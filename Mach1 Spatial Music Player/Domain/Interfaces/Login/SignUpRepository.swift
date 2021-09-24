import Foundation

protocol SignUpRepository {
    func signUp(dto: SignUpRequestDTO) async throws -> SignUpResponseDTO
}
