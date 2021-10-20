import Foundation

protocol SignInRepository {
    func signIn(dto: SignInRequestDTO) async throws -> SignInResponseDTO
}
