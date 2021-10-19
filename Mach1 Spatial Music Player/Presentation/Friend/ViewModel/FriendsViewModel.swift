//
//  FriendsViewModel.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 15. 10. 2021..
//

import Foundation
import SwiftUI

class FriendsViewModel: ObservableObject {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.getFriendsUseCase) private var getFriendsUseCase: GetFriendsUseCase
    @Published private(set) var uiState: FriendsState = .Loading
    
    @MainActor
    func get() async {
        self.uiState = .Loading
        do {
            let friends = try await getFriendsUseCase.execute()
            var items: [FriendListItem] = []
            friends.forEach { friend in
                items.append(FriendListItem(friend: friend, showProfile: false))
            }
            self.uiState = friends.isEmpty ? .NoResults : .Success(items)
        } catch {
            logger.error("Error when try to get friends: \(error)", LoggerCategoryType.Friend)
            self.uiState = .Error(error.localizedDescription)
        }
    }
}

enum FriendsState {
    case Loading
    case Error(String)
    case Success([FriendListItem])
    case NoResults
}
