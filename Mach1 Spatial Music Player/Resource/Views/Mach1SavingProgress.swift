//
//  SavingProgress.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 8. 10. 2021..
//

import SwiftUI

struct Mach1SavingProgress: View {
    @Translate private var saving = "Save in progress"
    
    var body: some View {
        HStack {
            _HSpacer()
            Mach1ProgressBar(shape: Rectangle(), height: 50, backgroundColor: .clear).frame(width: 80)
            _HSpacer()
            Text(saving).textStyle(TitleStyle())
            _HSpacer()
        }.padding(.horizontal)
    }
}

struct Mach1SavingProgress_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            Mach1SavingProgress()
        }
    }
}
