import SwiftUI

struct TrackItemView: View {
    let track: Track
    var action: ((Track) -> Void)
    
    var body: some View {
        Button {
            action(self.track)
        } label: {
            HStack {
                TrackItemInfoView(track: track)
                Spacer()
                Image(systemName: Constants.Image.System.Play.rawValue).foregroundColor(.Mach1Light)
            }
        }
    }
}

// MARK: Preview

struct TrackItemView_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            TrackItemView(track: findTrack()) { track in
                print("Selected track \(track.name)")
            }
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
