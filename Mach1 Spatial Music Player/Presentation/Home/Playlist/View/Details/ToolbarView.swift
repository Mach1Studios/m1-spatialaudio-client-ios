import SwiftUI

struct ToolbarView : View {
    let title: String
    var body: some View{
        HStack {
            Text(title).foregroundColor(Color.white).textStyle(TitleStyle())
            Spacer()
            Image(systemName: Constants.Image.System.Repeat.rawValue).foregroundColor(.white)
            Image(systemName: Constants.Image.System.Shuffle.rawValue).foregroundColor(.white)
        }
        .padding()
        .padding(.top, UIApplication.shared.distanceFromNotchWithOrNot)
        .padding(.horizontal)
        .background(Color.Mach1Darkest.opacity(Constants.Opacity.value))
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarView(title: "Title")
    }
}
