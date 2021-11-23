import SwiftUI
import Mach1AudioPlayerAPI
import SceneKit

struct PlayTrackView: View, OrientationSourceChange {
    let track: Track
    @Environment(\.verticalSizeClass) private var verticalSizeClass: UserInterfaceSizeClass?

    @State private var orientationSource: OrientationSourceType = .Device
    @StateObject private var viewModel = PlayTrackViewModel()
    @State private var isPlaying = false
    var spatialAudioPlayer: Mach1SpatialAudioPlayerImpl = Mach1SpatialAudioPlayerImpl(
        defaultScene,
        url: URL.init(fileURLWithPath: Bundle.main.path(forResource: "m1-debug-m1spatial", ofType: "wav")!)
    )
    
    var body: some View {
        Mach1View {
            if verticalSizeClass == .compact {
                HStack {
                    VStack {
                        self.header
                        self.segmentedPicker
                        Spacer()
                        self.playbackView
                        self.statusPlayer
                    }
                    self.spatialAudioPlayerView
                }.padding()
            } else {
                VStack {
                    self.header
                    self.segmentedPicker
                    self.spatialAudioPlayerView
                    self.playbackView
                    self.statusPlayer
                    Spacer()
                }.padding()
            }
        }
        .onAppear {
            spatialAudioPlayer.observe(self)
            spatialAudioPlayer.setSourceType(orientationSource)
        }
        .onDisappear { spatialAudioPlayer.clear() }
    }
    
    private var spatialAudioPlayerView: some View {
        spatialAudioPlayer.view(CGSize(width: 200, height: 200))
    }
    
    private var statusPlayer: some View {
        AudioPlayerControlsView(player: spatialAudioPlayer.player(),
                                timeObserver: PlayerTimeObserver(player: spatialAudioPlayer.player()),
                                durationObserver: PlayerDurationObserver(player: spatialAudioPlayer.player()),
                                itemObserver: PlayerItemObserver(player: spatialAudioPlayer.player()))
    }
    
    private var playbackView: some View {
        PlaybackStatusView(isPlaying: $isPlaying) {
            isPlaying.toggle()
            spatialAudioPlayer.playPause()
        }.padding(.top, Mach1Margin.VBig.rawValue)
    }
    
    private var segmentedPicker: some View {
        Mach1SegmentedPicker($orientationSource, options: OrientationSourceType.allCases) {
            spatialAudioPlayer.setSourceType(orientationSource)
        }.padding(.top, Mach1Margin.VBig.rawValue)
    }
    
    private var header: some View {
        HStack {
            Image(systemName: Constants.Image.System.Back.rawValue).foregroundColor(.Mach1Light)
            TrackItemInfoView(track: track)
            Spacer()
            Image(systemName: Constants.Image.System.NotFavourite.rawValue).foregroundColor(.Mach1Light)
        }
    }
    
    func headphoneMotionConnected() {
        if (isPlaying) {
            isPlaying.toggle()
            spatialAudioPlayer.playPause()
        }
        orientationSource = .Headphones
    }
    
    func headphoneMotionDisconnected() {
        if (isPlaying) {
            isPlaying.toggle()
            spatialAudioPlayer.playPause()
        }
        orientationSource = .Device
    }
}

fileprivate let defaultScene: SCNScene = {
    let scene = SCNScene(named: "head.obj")
    scene?.background.contents = UIColor(Color.Mach1Dark)
    return scene!
}()

// MARK: Preview

struct PlayTrackView_Previews: PreviewProvider {
    static var previews: some View {
        PlayTrackView(track: findTrack())
        PlayTrackView(track: findTrack())
            .previewInterfaceOrientation(.landscapeLeft)
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
