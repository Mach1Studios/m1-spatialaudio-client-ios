import Foundation
import SwiftUI

/**
    TYPE will be translated if exists in 'Localizable'
 */
struct Mach1SegmentedPicker<TYPE: Hashable>: View {
    let selectedType: Binding<TYPE>
    let options: [TYPE]
    
    init(_ selectedType: Binding<TYPE>, options: [TYPE]) {
        self.selectedType = selectedType
        self.options = options
        let mach1font = UIFont(name: Mach1Font.SemiBold.rawValue, size: Mach1TextSize.Medium.rawValue) ?? UIFont.systemFont(ofSize: Mach1TextSize.Medium.rawValue)
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.Mach1Yellow)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.Mach1Dark), .font: mach1font], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.Mach1Gray), .font: mach1font], for: .normal)
    }
    
    var body: some View {
        Picker("", selection: selectedType) {
            ForEach(options.indices, id: \.self) { type in
                Text(String(describing: options[type]).translate())
                    .tag(options[type])
            }
        }
        .pickerStyle(.segmented)
    }
}

// MARK: Preview

struct Mach1SegmentedPicker_Previews: PreviewProvider {
    @State static private var selectedTab: ExampleType = .One
    static var previews: some View {
        Mach1View {
            Mach1SegmentedPicker($selectedTab, options: ExampleType.allCases)
        }
    }
    private enum ExampleType: CaseIterable {
        case One
        case Two
    }
}
