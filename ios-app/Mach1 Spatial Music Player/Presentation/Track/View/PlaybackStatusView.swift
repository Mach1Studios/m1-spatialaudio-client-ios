import SwiftUI

struct PlaybackStatusView: View {
    var isPlaying: Binding<Bool>
    var playPause: (() -> Void)
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: Constants.Image.System.PreviousTrack.rawValue)
                    .resizable()
                    .frame(width: Constants.Image.Dimension.Small.rawValue, height: Constants.Image.Dimension.Small.rawValue)
                    .foregroundColor(.Mach1Gray)
                Spacer()
                Button { playPause() } label: {
                    Image(systemName: isPlaying.wrappedValue ? Constants.Image.System.PauseTrack.rawValue : Constants.Image.System.PlayTrack.rawValue)
                        .resizable()
                        .frame(width: Constants.Image.Dimension.Normal.rawValue, height: Constants.Image.Dimension.Normal.rawValue)
                        .foregroundColor(.Mach1Gray)
                }
                Spacer()
                Image(systemName: Constants.Image.System.NextTrack.rawValue)
                    .resizable()
                    .frame(width: Constants.Image.Dimension.Small.rawValue, height: Constants.Image.Dimension.Small.rawValue)
                    .foregroundColor(.Mach1Gray)
            }
        }
    }
}

// MARK: Preview

struct PlaybackStatusView_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            PlaybackStatusView(isPlaying: .constant(true)) {}
        }
    }
}
