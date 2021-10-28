import SwiftUI
import Mach1AudioPlayerAPI
import SceneKit

struct PlayTrackView: View {
    let track: Track
    @State private var orientationSource: OrientationSourceType = .Device
    @StateObject private var viewModel = PlayTrackViewModel()
    var spatialAudioPlayer: Mach1SpatialAudioPlayerImpl = Mach1SpatialAudioPlayerImpl(defaultScene, urls: testUrls)
    
    var body: some View {
        Mach1View {
            VStack {
                self.header
                Mach1SegmentedPicker($orientationSource, options: OrientationSourceType.allCases) {
                    spatialAudioPlayer.setSourceType(orientationSource)
                }.padding(.top, Mach1Margin.VBig.rawValue)
                spatialAudioPlayer.view(CGSize(width: 200, height: 200))
                PlaybackStatusView() {
                    spatialAudioPlayer.playPause()
                }.padding(.top, Mach1Margin.VBig.rawValue)
                Spacer()
            }.padding()
        }.onAppear { spatialAudioPlayer.setSourceType(orientationSource) }
        .onDisappear { spatialAudioPlayer.clear() }
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

// TODO: Only for testing
fileprivate let defaultScene: SCNScene = {
    let scene = SCNScene(named: "head.obj")
    scene?.background.contents = UIColor(Color.Mach1Dark)
    return scene!
}()
fileprivate let testUrls: [URL] = {
    var urls: [URL] = []
    for i in 0...7 {
        urls.append(URL.init(fileURLWithPath: Bundle.main.path(forResource: "00" + String(i), ofType: "aif")!))
    }
    return urls
}()


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
