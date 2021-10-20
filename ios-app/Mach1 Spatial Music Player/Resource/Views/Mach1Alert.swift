import SwiftUI

struct Mach1Alert: View {
    let title: String
    let description: String
    @Translate var close = "Close"
    @State var showingAlert: Bool = true
    
    init(_ title: String, description: String = "") {
        self.title = title
        self.description = description
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(.Mach1Yellow)
    }
    
    var body: some View {
        Text("")
            .actionSheet(isPresented: $showingAlert) {
                ActionSheet(
                    title: Text(title),
                    message: description.isEmpty ? nil : Text(description),
                    buttons: [ActionSheet.Button.cancel(Text(close))]
                )
            }
    }
}

// MARK: Preview

struct Mach1Alert_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            Mach1Alert("Title")
        }
    }
}
