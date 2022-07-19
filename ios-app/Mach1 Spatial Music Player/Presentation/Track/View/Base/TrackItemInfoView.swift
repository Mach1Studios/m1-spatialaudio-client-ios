import SwiftUI

struct TrackItemInfoView: View {
    let track: Track
    var body: some View {
        HStack {
            Mach1CircleImage(
                url: URL(string: track.url ?? "_"),
                dimension: Constants.Image.Dimension.Small,
                defaultSystemImage: .Track)
            VStack(alignment: .leading) {
                Text(track.name).foregroundColor(Color.Mach1Light).textStyle(SubBodyStyle())
                Text(track.description).foregroundColor(Color.Mach1Gray).textStyle(SmallBodyStyle())
            }
        }
    }
}

// MARK: Preview

struct TrackItemInfoView_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            TrackItemInfoView(track: findTrack())
        }
    }
    
    private static func findTrack() -> Track {
        var track: Track = Track(TrackDTO(id: UUID.init(), name: "Name", position: 0, description: "Description", url: nil))
        do {
            let tracks: [TrackDTO] = try ReadFile.json(resource: .Tracks)
            track = Track(tracks.first!)
        } catch {}
        return track
    }
}
