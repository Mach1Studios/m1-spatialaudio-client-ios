import SwiftUI

struct AddFriendItemView: View {
    @Translate var commonFriend = "Common friend"
    @Translate var commonFriends = "Common friends"
    let friend: Friend
    var body: some View {
        HStack {
            Mach1CircleImage(
                url: URL(string: friend.image ?? "_"),
                dimension: Constants.Image.Dimension.Small,
                defaultSystemImage: .Person)
            VStack(alignment: .leading) {
                Text(friend.name).foregroundColor(Color.Mach1Light).textStyle(SubBodyStyle())
                Text("\(friend.commonFriends) \(friend.commonFriends != 1 ? commonFriends : commonFriend)").foregroundColor(Color.Mach1Gray).textStyle(SmallBodyStyle())
            }
            Spacer()
            Image(systemName: Constants.Image.System.Add.rawValue).foregroundColor(.Mach1Light)
        }
    }
}

// MARK: Preview

struct AddFriendItemView_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            AddFriendItemView(friend: findFriend())
        }
    }
    
    private static func findFriend() -> Friend {
        var friend: Friend = Friend(FriendDTO(id: UUID.init(), username: "Name", commonFriends: 4, image: nil))
        do {
            let friends: [FriendDTO] = try ReadFile.json(resource: .Friends)
            friend = Friend(friends.first!)
        } catch {}
        return friend
    }
}
