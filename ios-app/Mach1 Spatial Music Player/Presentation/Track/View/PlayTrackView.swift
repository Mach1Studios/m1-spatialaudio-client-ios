import SwiftUI

struct PlayTrackView: View {
    let track: Track
    @StateObject var viewModel = PlayTrackViewModel()
    
    var body: some View {
        Mach1View {
            VStack {
                self.header
                Mach1SegmentedPicker($viewModel.orientationSource, options: OrientationSourceType.allCases)
                    .padding(.top, Mach1Margin.VBig.rawValue)
                Mach1OrientationCardWithIndicatorsView(width: UIScreen.main.bounds.width * 0.9)
                    .padding(.top, Mach1Margin.VBig.rawValue)
                PlaybackStatusView()
                    .padding(.top, Mach1Margin.VBig.rawValue)
                    .padding()
                Spacer()
            }.padding()
        }
    }
    
    private var header: some View {
        HStack {
            Image(systemName: Constants.Image.System.Back.rawValue).foregroundColor(.Mach1Light)
            TrackItemInfoView(track: track)
            Spacer()
            Image(systemName: Constants.Image.System.NotFavourite.rawValue).foregroundColor(.Mach1Light)
        }
    }
}

// MARK: Preview

struct PlayTrackView_Previews: PreviewProvider {
    static var previews: some View {
        PlayTrackView(track: findTrack())
    }
    
    private static func findTrack() -> Track {
        var track: Track = Track(TrackDTO(id: UUID.init(), name: "Name", description: "Description", url: nil))
        do {
            let tracks: [TrackDTO] = try ReadFile.json(resource: .Tracks)
            track = Track(tracks.first!)
        } catch {}
        return track
    }
}
