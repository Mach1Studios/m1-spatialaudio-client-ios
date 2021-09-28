import SwiftUI

struct Mach1SectionedView<SECTION>: View where SECTION: Mach1Sectioned & Identifiable {
    let sections: [SECTION]
    var body: some View {
        return List(sections) { section in
            Section(header: Text(section.name.uppercased()).textStyle(SubTitleBoldStyle())) {
                LazyVGrid(columns: Array(repeating: .init(.adaptive(minimum: 100, maximum: 500)), count: 2), spacing: Mach1Margin.Small.rawValue) {
                    ForEach(section.sectionItems, id: \.title) { item in
                        Mach1CardImage(
                            title: item.title,
                            url: URL(string: item.url ?? ""),
                            height: Constants.Image.Dimension.Big,
                            defaultImage: Constants.Image.Default.PlayList)
                    }
                }
            }
            .listRowInsets(EdgeInsets(top: Mach1Margin.Small.rawValue, leading: 0, bottom: Mach1Margin.Small.rawValue, trailing: 0))
            .listRowBackground(Color.clear)
        }
        .listStyle(InsetGroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
    }
}

// MARK: Preview

struct Mach1SectionedView_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            Mach1SectionedView(sections: sections)
        }
    }
    private static var sections: [SectionedPlaylist] {
        var sections: [SectionedPlaylist] = []
        do { sections = try ReadFile.json(resource: .SectionedPlaylists) } catch {}
        return sections
    }
}
