//
//  BaseActionResponseDTO.swift
//  Mach1 Spatial Music Player
//
//  Created by EurobitDev on 7. 10. 2021..
//

import Foundation

protocol BaseProfileActionResponseDTO: Codable, Equatable {
    var responseCode: Int? { get }
    var errorMessage: String? { get }
}

protocol BaseProfileForGetRequestDTO: Codable, Equatable {
    var id: String { get }
}
