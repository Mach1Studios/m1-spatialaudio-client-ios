//
//  Mach1ProfileHeaderView.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 4. 10. 2021..
//

import SwiftUI

struct Mach1ProfileHeaderView<T: Mach1BaseProfile>: View {
    /**
     //MARK: - Parameters
        isRoot - if is true in navigation bar navigation arrow is hidden
        isEditable - if is true cover picture and avatar have icons for edit
     */
    var profile: T? = nil
    var isRoot: Bool = false
    var isEditable: Bool = false
    var title: String?
    let geometry: GeometryProxy
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        let height = geometry.size.height
        let offset: CGFloat = height.isNaN ? -1 * (height * 0.23) : -160
        let imageDimension = Constants.Image.Dimension(rawValue: geometry.size.height * 0.33) ?? Constants.Image.Dimension.MediumBig
        
        VStack {
            ZStack {
                Mach1CorrugatedImage(url: URL(string: profile != nil ? (profile?.coverImage ?? "") : ""), height: imageDimension, defaultImage: Constants.Image.Default.Person)
                    .overlay(Mach1NavigationView(title: title ?? "", action: isRoot ? nil : {self.presentationMode.wrappedValue.dismiss()}).padding().offset(y: isRoot ? 25 : 0), alignment: .topLeading)
                if isEditable {
                Button("") {print("Edit")}
                .buttonStyle(Mach1ImageButtonStyle(icon: Constants.Image.System.Camera.rawValue)).frame(width: imageDimension.rawValue * 1.48, height: imageDimension.rawValue * 0.5, alignment: .bottomTrailing)
                }
                
            }
            ZStack {
                Mach1CircleImage(url: URL(string: profile != nil ? (profile?.profileImage ?? "") : ""), dimension: Constants.Image.Dimension.Bigger, defaultSystemImage: Constants.Image.Default.Person).withShadow()
                if isEditable {
                Button("") {print("Edit")}
                .buttonStyle(Mach1ImageButtonStyle(icon: Constants.Image.System.Camera.rawValue)).frame(width: Constants.Image.Dimension.Bigger.rawValue * 0.66, height: Constants.Image.Dimension.Bigger.rawValue, alignment: .bottomTrailing)
                }
            }.offset(y: offset)
                .padding(.bottom, offset + 70)
        }.ignoresSafeArea()
    }
}

struct Mach1ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            Mach1ProfileHeaderView<Profile>(isRoot: false, isEditable: true, title: "Monica Belluci", geometry: geometry)
        }
    }
}
