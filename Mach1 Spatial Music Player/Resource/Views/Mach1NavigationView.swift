//
//  Mach1NavigationView.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 4. 10. 2021..
//

import SwiftUI

struct Mach1NavigationView: View {
    let title: String?
    var action: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            if let onPress = action {
                Button(action: onPress) {
                    Image(systemName: Constants.Image.System.Back.rawValue).foregroundColor(.Mach1Light)
                }
            }
            Text(title ?? "").textStyle(TitleStyle()).padding()
        }
    }
}

struct Mach1NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            Mach1NavigationView(title: "Monica Bellucci", action: {print("Back")})
        }
    }
}
