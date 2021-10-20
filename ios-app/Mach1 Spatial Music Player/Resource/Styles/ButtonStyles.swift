import SwiftUI

//MARK: - Button Styles
//MARK: Rounded button
struct Mach1ButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.horizontal)
            .padding(EdgeInsets(top: Mach1Margin.Normal.rawValue, leading: Mach1Margin.Big.rawValue, bottom: Mach1Margin.Normal.rawValue, trailing: Mach1Margin.Big.rawValue))
            .foregroundColor(.white)
            .background(Color.Mach1Yellow)
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
            .cornerRadius(Constants.Rounded.normal.rawValue)
            .font(Constants.Fonts.subTitleBold)
            .textCase(.uppercase)
            
    }
}

//MARK: Icon and text button
struct Mach1TextButtonStyle: ButtonStyle {
    var icon: String?
    var iconColor: Color? = nil
    var textColor: Color? = nil
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if let iconName = icon {
            Image(systemName: iconName)
                    .foregroundColor(iconColor ?? .Mach1GrayLight)
            }
            configuration.label
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .foregroundColor(textColor ?? .Mach1GrayLight)
                .font(Constants.Fonts.title)
        }.scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            
    }
}

//MARK: Icon button
struct Mach1ImageButtonStyle: ButtonStyle {
    let icon: String
    var iconColor: Color? = nil
    
    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: icon)
                .foregroundColor(iconColor ?? .Mach1GrayLight)
                .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

// MARK: - Preview

struct Mach1ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            VStack {
                Button("Title") {}.buttonStyle(Mach1ButtonStyle())
                Button("Text Button Style") {}.buttonStyle(Mach1TextButtonStyle(icon: Constants.Image.System.Edit.rawValue))
                Button("") {}.buttonStyle(Mach1ImageButtonStyle(icon: Constants.Image.System.Edit.rawValue))
            }
        }
    }
}
