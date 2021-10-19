//
//  FriendListItem.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 18. 10. 2021..
//

import Foundation
import SwiftUI

class FriendListItem: ObservableObject {
    init(friend: Friend, showProfile: Bool) {
        self.friend = friend
        self.showProfile = showProfile
    }
    var friend: Friend
    @Published var showProfile: Bool
    
    func setShowProfileToTrue() {
        self.showProfile = true
    }
}
