import Foundation

class PlayTrackViewModel: ObservableObject {
    @Published var orientationSource: OrientationSourceType = .Device
}
