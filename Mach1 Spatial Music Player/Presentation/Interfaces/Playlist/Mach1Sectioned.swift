import Foundation

protocol Mach1Sectioned: Identifiable {
    var name: String { get }
    var sectionItems: [Mach1SectionItem] { get }
}

protocol Mach1SectionItem {
    var id: UUID { get }
    var title: String { get }
    var url: String? { get }
}
