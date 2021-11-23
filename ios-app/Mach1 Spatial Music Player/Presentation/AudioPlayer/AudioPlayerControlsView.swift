import SwiftUI
import AVFoundation
import Combine

struct AudioPlayerControlsView: View {
    private enum PlaybackState: Int {
        case waitingForSelection
        case buffering
        case playing
    }
    let player: AVPlayer
    let timeObserver: PlayerTimeObserver
    let durationObserver: PlayerDurationObserver
    let itemObserver: PlayerItemObserver
    @State private var currentTime: TimeInterval = 0
    @State private var currentDuration: TimeInterval = 0
    @State private var state = PlaybackState.waitingForSelection
    
    var body: some View {
        VStack {
            Slider(value: $currentTime,
                   in: 0...currentDuration,
                   onEditingChanged: sliderEditingChanged,
                   minimumValueLabel: Text("\(SecondsRepresentation.formatSecondsToHMS(currentTime))"),
                   maximumValueLabel: Text("\(SecondsRepresentation.formatSecondsToHMS(currentDuration))")) {}
            .disabled(state != .playing)
            .foregroundColor(Color.Mach1Yellow)
        }
        .padding()
        .onReceive(timeObserver.publisher) { time in
            self.currentTime = time
            if time > 0 {
                self.state = .playing
            }
        }
        .onReceive(durationObserver.publisher) { duration in
            self.currentDuration = duration
        }
        .onReceive(itemObserver.publisher) { hasItem in
            self.state = hasItem ? .buffering : .waitingForSelection
            self.currentTime = 0
            self.currentDuration = 0
        }
    }
    
    private func sliderEditingChanged(editingStarted: Bool) {
        if editingStarted {
            timeObserver.pause(true)
        }
        else {
            state = .buffering
            let targetTime = CMTime(seconds: currentTime,
                                    preferredTimescale: 600)
            player.seek(to: targetTime) { _ in
                self.timeObserver.pause(false)
                self.state = .playing
            }
        }
    }
}
