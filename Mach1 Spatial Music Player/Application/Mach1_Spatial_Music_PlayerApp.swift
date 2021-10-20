import SwiftUI

@main
struct Mach1_Spatial_Music_PlayerApp: App {
    @StateObject var routing = Routing()
    init() {
        MockedRepositoryInjectionFactory.setUp()
    }
    var body: some Scene {
        WindowGroup {
            // TODO delete and uncomment
            PlayTrackView(track: findTrack())
            /*
            switch(routing.route) {
            case .Login:
                SignInView()
            case .Home:
                HomeView()
            }
            */
        }
    }
    
    private func findTrack() -> Track {
        var track: Track = Track(TrackDTO(id: UUID.init(), name: "Name", description: "Description", url: nil))
        do {
            let tracks: [TrackDTO] = try ReadFile.json(resource: .Tracks)
            track = Track(tracks.first!)
        } catch {}
        return track
    }
}
