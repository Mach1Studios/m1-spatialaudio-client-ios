//
//  FriendItemView.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 15. 10. 2021..
//

import SwiftUI

struct FriendItemView: View {
    @Translate var commonFriend = "Common friend"
    @Translate var commonFriends = "Common friends"
    @StateObject var friend: FriendListItem
    var navigateTo: AnyView
    
    var body: some View {
            HStack {
                Mach1CircleImage(
                    url: URL(string: friend.friend.image ?? "_"),
                    dimension: Constants.Image.Dimension.Small,
                    defaultSystemImage: .Person)
                VStack(alignment: .leading) {
                    Text(friend.friend.name).foregroundColor(Color.Mach1Light).textStyle(SubBodyStyle())
                    Text("\(friend.friend.commonFriends) \(friend.friend.commonFriends != 1 ? commonFriends : commonFriend)").foregroundColor(Color.Mach1Gray).textStyle(SmallBodyStyle())
                }
                Spacer()
                Image(systemName: Constants.Image.System.RemovePerson.rawValue).foregroundColor(.Mach1Light)
            }.onTapGesture(perform: {
                friend.setShowProfileToTrue()
            }).sheet(isPresented: State(wrappedValue: friend.showProfile).projectedValue) {
                navigateTo
            }
        }
    }


struct FriendItemView_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            FriendItemView(friend: findFriend(), navigateTo:  AnyView(EmptyView()))
        }
    }
    
    private static func findFriend() -> FriendListItem {
        var friend: Friend = Friend(FriendDTO(id: UUID.init(), name: "Name", commonFriends: 4, image: nil))
        do {
            let friends: [FriendDTO] = try ReadFile.json(resource: .Friends)
            friend = Friend(friends.first!)
        } catch {}
        return FriendListItem(friend: friend, showProfile: false)
    }
}
