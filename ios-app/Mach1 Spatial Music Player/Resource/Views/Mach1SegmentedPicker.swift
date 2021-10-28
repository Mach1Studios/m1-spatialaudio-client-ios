import Foundation
import SwiftUI

/**
    TYPE will be translated if exists in 'Localizable'
 */
struct Mach1SegmentedPicker<TYPE: Hashable & Equatable>: View {
    let selectedType: Binding<TYPE>
    let options: [TYPE]
    var onChange: (() -> Void)?
    
    init(_ selectedType: Binding<TYPE>, options: [TYPE], onChange: (() -> Void)? = nil) {
        self.selectedType = selectedType
        self.options = options
        self.onChange = onChange
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
        .onChange(of: selectedType.wrappedValue) { _ in onChange?() }
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
