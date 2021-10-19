//
//  FriendsView.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 15. 10. 2021..
//

import SwiftUI

struct FriendsView: View {
    @Translate private var friendsTitle = "Friends"
    @Translate private var noResults = "No results"
    @Translate private var errorTitle = "Error"
    
    @State var showFriendProfileView = false
    
    
    @StateObject private var viewModel = FriendsViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    init() {
        UIScrollView.appearance().backgroundColor = UIColor(Color.Mach1Dark)
    }
    
    var body: some View {
            Mach1View {
                self.observeUiState
            }.task { await viewModel.get() }
    }
    
    @ViewBuilder
    private var observeUiState: some View {
        switch viewModel.uiState {
        case .Loading:
            Mach1ProgressBar(shape: Circle(), height: Constants.Dimension.progressBar.rawValue, backgroundColor: .clear)
        case .Error(let error):
            Mach1Alert(errorTitle, description: error)
        case .Success(let items):
            VStack {
                Button("") {self.presentationMode.wrappedValue.dismiss()}
                .buttonStyle(Mach1ImageButtonStyle(icon: Constants.Image.System.Back.rawValue, iconColor: .white)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 25, alignment: .leading).padding(.horizontal).padding(.top, 10)
                    Text(friendsTitle).textStyle(NavigationStyle()).foregroundColor(.white).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 25, alignment: .leading).padding(.horizontal)
                List {
                    ForEach(items, id: \.friend.id) {
                        FriendItemView(friend: $0, navigateTo: AnyView(FriendProfileView(friendId: $0.friend.id)))
                        
                    }
                    .listRowBackground(Color.Mach1Darkest)
                }
            }
        case .NoResults:
            Text(noResults)
                .foregroundColor(.Mach1GrayLight)
                .textStyle(TitleStyle())
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
