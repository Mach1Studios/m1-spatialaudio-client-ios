import Foundation
import SwiftUI


struct NavigationStyle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(Constants.Fonts.bigTitle)
    }
}

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Constants.Fonts.title)
            .foregroundColor(.Mach1Light)
    }
}

struct SubTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Constants.Fonts.subTitle)
            .foregroundColor(.Mach1Light)
    }
}

struct SubTitleBoldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Constants.Fonts.subTitleBold)
            .foregroundColor(.Mach1Light)
    }
}

struct BodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Constants.Fonts.body)
            .foregroundColor(.Mach1Light)
    }
}

struct SubBodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Constants.Fonts.subBody)
            .foregroundColor(.Mach1Light)
    }
}

struct SmallBodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Constants.Fonts.smallBody)
            .foregroundColor(.Mach1Light)
    }
}

extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

// MARK: Preview

struct TextStyles_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            VStack {
                Text("Navigation").textStyle(NavigationStyle())
                Text("Title").foregroundColor(Color.Mach1Yellow).textStyle(TitleStyle())
                Text("Sub title").textStyle(SubTitleStyle())
                Text("Body").textStyle(BodyStyle())
                Text("Sub-Body").textStyle(SubBodyStyle())
                Text("Very Small Body").textStyle(SmallBodyStyle())
            }
        }
    }
}
