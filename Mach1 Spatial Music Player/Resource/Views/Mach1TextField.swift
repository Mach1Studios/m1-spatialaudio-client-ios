import Foundation
import SwiftUI

struct Mach1TextField: View {
    let text: Binding<String>
    let placeHolder: String
    var isMultiline: Bool = false
    
    var body: some View {
        if isMultiline {
            //TODO: napraviti da placeholder
            ZStack {
                VStack {
                    TextEditor(text: text)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 150)
                        .foregroundColor(Color.white)
                        .padding(5)
                }.overlay(
                    RoundedRectangle(cornerRadius: Constants.Rounded.value)
                        .stroke(Color.Mach1Gray, lineWidth: 0.5)
                )
                
                if text.wrappedValue.isEmpty {
                    Text(placeHolder)
                        .foregroundColor(Color.Mach1Gray)
                        .padding(.horizontal)
                        .padding(.vertical)
                        .offset(x: -135, y: -55)
                }
            }
                
        } else {
            TextField("", text: text)
                .modifier(PlaceholderStyle(showPlaceHolder: text.wrappedValue.isEmpty, placeholder: placeHolder))
                .textFieldStyle(Mach1FieldStyle())
        }
    }
}

private struct Mach1FieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
            .padding(Mach1Margin.Normal.rawValue)
            .font(Constants.Fonts.subBody)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: Constants.Rounded.value, style: .continuous)
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
    @State static private var multilineField = ""
    
    static var previews: some View {
        Mach1View {
            VStack {
                Mach1TextField(text: $inputField, placeHolder: "Enter...").padding()
                Mach1TextField(text: $multilineField, placeHolder: "Enter...", isMultiline: true).padding()
            }
        }
    }
}
