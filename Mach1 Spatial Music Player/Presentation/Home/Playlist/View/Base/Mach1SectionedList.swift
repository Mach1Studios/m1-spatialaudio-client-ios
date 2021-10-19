import SwiftUI

struct Mach1SectionedView<SECTION>: View where SECTION: Mach1Sectioned & Identifiable {
    let sections: [SECTION]
    var action: ((_ playlist: UUID) -> Void)? = nil
    var body: some View {
        return ScrollView {
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: Mach1Margin.VBig.rawValue) {
                ForEach(sections, id: \.name) { section in
                    Section(header: Text(section.name.uppercased()).textStyle(SubTitleBoldStyle()).frame(maxWidth: .infinity, alignment: .leading)) {
                        ForEach(section.sectionItems, id: \.id) { item in
                            Mach1CardImage(
                                title: item.title,
                                url: URL(string: item.url ?? ""),
                                height: Constants.Image.Dimension.Big,
                                defaultImage: Constants.Image.Default.PlayList) { self.action?(item.id) }
                        }
                    }.padding(EdgeInsets(top: 0, leading: Mach1Margin.Small.rawValue, bottom: 0, trailing: Mach1Margin.Small.rawValue))
                }
            }
            .listRowInsets(EdgeInsets(top: Mach1Margin.Small.rawValue, leading: 0, bottom: Mach1Margin.Small.rawValue, trailing: 0))
            .listRowBackground(Color.clear)
        }
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
