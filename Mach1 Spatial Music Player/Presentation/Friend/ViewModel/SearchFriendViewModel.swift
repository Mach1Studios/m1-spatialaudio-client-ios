import SwiftUI

class SearchFriendViewModel: ObservableObject {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.findFriendUseCase) private var findFriendUseCase: FindFriendUseCase
    @Published var searchText = ""
    @Published private(set) var uiState: FindFriendState = .Loading
    
    @MainActor
    func filter() async {
        self.uiState = .Loading
        do {
            let friends = try await findFriendUseCase.execute(search: searchText)
            self.uiState = friends.isEmpty ? .NoResults : .Success(friends)
        } catch {
            logger.error("Error when try to find friend: \(error)", LoggerCategoryType.Friend)
            self.uiState = .Error(error.localizedDescription)
        }
    }
    
}

enum FindFriendState {
    case Loading
    case Error(String)
    case Success([Friend])
    case NoResults
}
