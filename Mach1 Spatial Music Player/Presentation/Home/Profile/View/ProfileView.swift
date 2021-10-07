import SwiftUI

struct ProfileView: View {
    @State var showEditProfileView = false
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(.Mach1Gray)
        UITabBar.appearance().backgroundColor = UIColor(.Mach1Darkest)
        UITabBar.appearance().barTintColor = UIColor(.Mach1Darkest)
    }
    
    var body: some View {
        Mach1View {
            GeometryReader { geometry in
                VStack {
                    Mach1ProfileHeaderView(isRoot: true, isEditable: false, title: "Username", geometry: geometry)
                    VStack {
                    HStack {
                        Button("2 friends") {print("2 friends")}
                        .buttonStyle(Mach1TextButtonStyle(icon: Constants.Image.System.Friends.rawValue))
                        _HSpacer()
                        Button("") {self.showEditProfileView.toggle()}.sheet(isPresented: $showEditProfileView) {
                            EditProfileView()
                        }
                        .buttonStyle(Mach1ImageButtonStyle(icon: Constants.Image.System.Edit.rawValue))
                    }.padding(.horizontal)
                        Divider()
                            .frame(height: 1)
                            .background(Color.Mach1Darkest).padding(.vertical)
                    }.offset(y: -24).padding(.vertical, -24)
                    Mach1ListView(items: [
                        Mach1ListItem(icon: Constants.Image.System.Favourites.rawValue, title: "Favourite tracks", action: {print("Favourites tracks")}),
                        Mach1ListItem(icon: Constants.Image.System.Find.rawValue, title: "Find friends", action: {print("Find friends")}),
                        Mach1ListItem(icon: Constants.Image.System.Logout.rawValue, title: "Logout", action: {print("Logout")})])
                }.ignoresSafeArea()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
