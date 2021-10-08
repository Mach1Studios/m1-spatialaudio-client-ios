import Foundation

protocol GetFavouriteTracksUseCase {
    func execute(search: String?) async throws -> [Track]
}
