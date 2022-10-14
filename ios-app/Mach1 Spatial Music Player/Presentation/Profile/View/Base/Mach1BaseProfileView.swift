import SwiftUI

struct Mach1BaseProfileView: View {
    @State var showEditProfileView = false
    @State var showFreinds = false
    @State var showFavouriteTracksView = false
    @State var showFindFriendsView = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject private var viewModel = ProfileViewModel()
    
    @Translate private var friendTitle = "friend"
    @Translate private var friendsTitle = "friends"
    @Translate private var favouriteTracksTitle = "Favourite tracks"
    @Translate private var findFriendsTitle = "Find friends"
    @Translate private var logoutTitle = "Logout"
    
    let profile: Profile
    
    var body: some View {
            GeometryReader { geometry in
                VStack {
                    Mach1ProfileHeaderView<Profile>(profile: profile, isRoot: true, isEditable: false, title: self.profile.username, geometry: geometry)
                    VStack {
                    HStack {
                        Button("\(self.profile.numberOfFriends) \(self.profile.numberOfFriends == 1 ? friendTitle : friendsTitle)") {self.showFreinds.toggle()}
                        .sheet(isPresented: $showFreinds) {
                            FriendsView()
                        }
                        .buttonStyle(Mach1TextButtonStyle(icon: Constants.Image.System.Friends.rawValue))
                        _HSpacer()
                        Button("") {self.showEditProfileView.toggle()}
                        .sheet(isPresented: $showEditProfileView) {
                            EditProfileView()
                        }
                        .buttonStyle(Mach1ImageButtonStyle(icon: Constants.Image.System.Edit.rawValue))
                    }.padding(.horizontal)
                        Divider()
                            .frame(height: 1)
                            .background(Color.Mach1Darkest).padding(.vertical)
                    }.offset(y: -24).padding(.vertical, -24)
                    Mach1ListView(items: [
                        Mach1ListItem(icon: Constants.Image.System.Favourites.rawValue, title: favouriteTracksTitle, action: {
                            showFavouriteTracksView.toggle()
                        }, isPressed: $showFavouriteTracksView, navigateTo: AnyView(SearchFavoutireTracksView())),
                        Mach1ListItem(icon: Constants.Image.System.Find.rawValue, title: findFriendsTitle, action: {
                            showFindFriendsView.toggle()
                        }, isPressed: $showFindFriendsView, navigateTo: AnyView(SearchFriendView())),
                        Mach1ListItem(icon: Constants.Image.System.Logout.rawValue, title: logoutTitle, action: {
                            Task.init {
                             await viewModel.logout()
                            }
                            
                        }, isPressed: $showFavouriteTracksView, navigateTo: AnyView(EmptyView()))
                    ])
                }.ignoresSafeArea()
            }
        }
}

struct Mach1BaseProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            // Mach1BaseProfileView(profile: Profile(ProfileResponseDTO(id: "4d9eff5f-2d95-4994-82f2-caf3959be2c8", username: "Username", coverImage: nil, profileImage: nil, numberOfFriends: 2)))
        }
    }
}
