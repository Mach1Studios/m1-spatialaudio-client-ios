//
//  EditProfileView.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 6. 10. 2021..
//

import SwiftUI

struct EditProfileView: View {
    @State var usernameText = ""
    @State var bioText = ""
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(.Mach1Gray)
        UITabBar.appearance().backgroundColor = UIColor(.Mach1Darkest)
        UITabBar.appearance().barTintColor = UIColor(.Mach1Darkest)
        UITextView.appearance().backgroundColor = UIColor(.Mach1Dark)
    }
    var body: some View {
        Mach1View {
            GeometryReader { geometry in
                VStack {
                    Mach1ProfileHeaderView(isRoot: false, isEditable: true, title: "", geometry: geometry)
                    VStack {
                        Mach1TextField(text: $usernameText, placeHolder: "Enter username").padding()
                        Button("Change password") {print("Change password")}
                        .buttonStyle(Mach1TextButtonStyle()).padding()
                        Mach1TextField(text: $bioText, placeHolder: "Enter bio", isMultiline: true).padding()
                    }
                    Button("Save changes") {print("Save changes")}
                    .buttonStyle(Mach1ButtonStyle()).padding()
                }.ignoresSafeArea()
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
