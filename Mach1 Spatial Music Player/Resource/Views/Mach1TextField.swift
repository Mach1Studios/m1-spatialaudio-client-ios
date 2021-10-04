import Foundation
import SwiftUI

struct Mach1TextField: View {
    let text: Binding<String>
    let placeHolder: String
    var body: some View {
        TextField("", text: text)
            .modifier(PlaceholderStyle(showPlaceHolder: text.wrappedValue.isEmpty, placeholder: placeHolder))
            .textFieldStyle(Mach1FieldStyle())
    }
}

private struct Mach1FieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
            .padding(Mach1Margin.Normal.rawValue)
            .font(Constants.Fonts.subBody)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: Constants.Rounded.normal.rawValue, style: .continuous)
                    .stroke(Color.Mach1Gray, lineWidth: Constants.LineWidtch.value)
            )
        }
}

private struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String
    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .padding(.horizontal, Mach1Margin.Normal.rawValue)
                    .font(Constants.Fonts.subBody)
                    .foregroundColor(.Mach1Gray)
            }
            content
        }
    }
}

// MARK: Preview

struct Mach1TextField_Previews: PreviewProvider {
    @State static private var inputField = ""
    static var previews: some View {
        Mach1View {
            Mach1TextField(text: $inputField, placeHolder: "Enter..").padding()
        }
    }
}
