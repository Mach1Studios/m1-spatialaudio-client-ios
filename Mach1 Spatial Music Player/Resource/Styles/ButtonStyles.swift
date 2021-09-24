import SwiftUI

struct Mach1ButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.horizontal)
            .padding(EdgeInsets(top: Mach1Margin.Normal.rawValue, leading: Mach1Margin.Big.rawValue, bottom: Mach1Margin.Normal.rawValue, trailing: Mach1Margin.Big.rawValue))
            .foregroundColor(.white)
            .background(Color.Mach1Yellow)
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
            .cornerRadius(Constants.Rounded.value)
            .font(Constants.Fonts.subTitleBold)
            .textCase(.uppercase)
            
    }
}

// MARK: Preview

struct Mach1ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            Button("Title") {}.buttonStyle(Mach1ButtonStyle())
        }
    }
}
