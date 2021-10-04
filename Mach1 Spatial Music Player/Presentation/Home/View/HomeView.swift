import SwiftUI

struct HomeView: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(.Mach1Gray)
        UITabBar.appearance().backgroundColor = UIColor(.Mach1Darkest)
        UITabBar.appearance().barTintColor = UIColor(.Mach1Darkest)
    }
    var body: some View {
        Mach1View {
            TabView {
                SectionedPlayistsView().tabItem { Image(Constants.Image.Custom.Mach1LogoTabItem.rawValue).renderingMode(.template) }
                ProfileView().tabItem { Image(systemName: Constants.Image.System.Person.rawValue) }
            }
        }
    }
}

// MARK: Preview

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
