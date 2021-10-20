//
//  GetPlaylistsForProfileUseCaseImpl.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 15. 10. 2021..
//

import Foundation

private struct GetPlaylistsForProfileUseCaseKey: InjectionKey {
    static var currentValue: GetPlaylistsForProfileUseCase = GetPlaylistsForProfileUseCaseImpl()
}

extension InjectedValues {
    var getPlaylistsForProfileUseCase: GetPlaylistsForProfileUseCase {
        get { Self[GetPlaylistsForProfileUseCaseKey.self] }
        set { Self[GetPlaylistsForProfileUseCaseKey.self] = newValue }
    }
}

actor GetPlaylistsForProfileUseCaseImpl: GetPlaylistsForProfileUseCase {
    @Inject(\.logger) private var logger: LoggerFactory
    @Inject(\.playlistDetailsRepository) private var playlistRepository: PlaylistDetailsRepository
    
    func execute(profileId: UUID) async throws -> [SectionedPlaylistItem] {
        logger.info("USE CASE: \(type(of: self))", LoggerCategoryType.FriendProfile)
        let response = try await playlistRepository.getPlaylistsForProfile(profileId: profileId)
        logger.info("Response get friend's playlists: \(response)", LoggerCategoryType.FriendProfile)
        return response.map { SectionedPlaylistItem($0) }
    }
}
