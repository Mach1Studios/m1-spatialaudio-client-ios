//
//  Mach1ListView.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 6. 10. 2021..
//

import SwiftUI

struct Mach1ListView: View {
    let items: [Mach1ListItem]
    var body: some View {
        VStack {
            ForEach(items, id: \.self) { item in
                if let onClick = item.action {
                    HStack {
                        HStack {
                            if let iconName = item.icon {
                                Image(systemName: iconName).foregroundColor(.Mach1GrayLight)
                            }
                            Text(item.title).foregroundColor(.Mach1GrayLight)
                        }
                        
                            Spacer()
                            Button("") {onClick()}
                            .buttonStyle(Mach1ImageButtonStyle(icon: Constants.Image.System.Navigate.rawValue))
                        
                    }.padding(.horizontal).padding(.vertical, 5).contentShape(Rectangle()).onTapGesture(perform: {onClick()})
                }
            }
        }
    }
}

struct Mach1ListItem: Equatable, Identifiable, Hashable {
    
    var id: UUID = UUID()    
    var icon: String?
    let title: String
    var action: (() -> Void)? = nil
    
    static func == (lhs: Mach1ListItem, rhs: Mach1ListItem) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.icon == rhs.icon
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id.hashValue)
        hasher.combine(title.hashValue)
        if let iconName = icon {
            hasher.combine(iconName.hashValue)
        } else {
            hasher.combine(UUID().hashValue)
        }
    }
    
    
}

struct Mach1ListView_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            let items = [
                Mach1ListItem(icon: Constants.Image.System.Favourites.rawValue, title: "Favourite tracks", action: {print("Favourites tracks")}),
                Mach1ListItem(icon: Constants.Image.System.Find.rawValue, title: "Find friends", action: {print("Find friends")}),
                Mach1ListItem(icon: Constants.Image.System.Logout.rawValue, title: "Logout", action: {print("Logout")})
            ]
            Mach1ListView(items: items)
        }
    }
}
