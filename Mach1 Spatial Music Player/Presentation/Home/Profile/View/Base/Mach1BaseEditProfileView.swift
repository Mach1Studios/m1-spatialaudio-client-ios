//
//  EditProfileView.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 6. 10. 2021..
//

import SwiftUI

struct Mach1BaseEditProfileView: View {
    @Translate var enterUsername = "Enter username"
    @Translate var changePassword = "Change password"
    @Translate var enterBio = "Enter bio"
    @Translate var saveChanges = "Save changes"
    
    @StateObject private var viewModel = EditProfileViewModel()
    
    @State var usernameText = ""
    @State var bioText = ""
    @State var coverImageURL = ""
    @State var profileImageURL = ""
    
    @State var savingChanges: Bool = false
    
    let profile: ProfileForEdit
    
    init(profile: ProfileForEdit) {
        self.profile = profile
        _savingChanges = State(initialValue: false)
        _usernameText = State(initialValue: profile.username)
        _bioText = State(initialValue: profile.biography ?? "")
    }
    
    init(profile: ProfileForEdit, savingChanges: Bool) {
        self.profile = profile
        _savingChanges = State(wrappedValue: savingChanges)
        _usernameText = State(initialValue: profile.username)
        _bioText = State(initialValue: profile.biography ?? "")
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Mach1ProfileHeaderView<ProfileForEdit>(profile: profile, isRoot: false, isEditable: true, title: "", geometry: geometry)
                VStack {
                    Mach1TextField(text: $usernameText, placeHolder:  enterUsername).padding()
                    Button(changePassword) {print("Change password")}
                    .buttonStyle(Mach1TextButtonStyle()).padding()
                    Mach1TextField(text: $bioText, placeHolder: enterBio, isMultiline: true).padding()
                }
                if(!savingChanges) {
                    Button(saveChanges) {
                        Task.init {
                            self.viewModel.username = $usernameText.wrappedValue
                            self.viewModel.biography = $bioText.wrappedValue
                            
                            await self.viewModel.saveChanges(profile: profile)
                        }
                    }
                    .buttonStyle(Mach1ButtonStyle()).padding()
                } else {
                    Mach1SavingProgress()
                }
            }.ignoresSafeArea()
        }
    }
    
}

struct MAch1BaseEditProfileView_Previews: PreviewProvider {
    @Binding var savingChanges: Bool
    
    static var previews: some View {
        Mach1BaseEditProfileView(profile: ProfileForEdit(ProfileForEditResponseDTO(id: "4d9eff5f-2d95-4994-82f2-caf3959be2c8", username: "John Doe", coverImage: nil, profileImage: nil, biography: nil)))
    }
}
