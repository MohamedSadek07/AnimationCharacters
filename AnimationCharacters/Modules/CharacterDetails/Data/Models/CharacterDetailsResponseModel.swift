//
//  CharacterDetailsResponseModel.swift
//  iJusoor
//
//  Created by Mohamed Sadek on 25/11/2024.
//

import Foundation

// MARK: - CharacterDetailsResponseModel
struct CharacterDetailsResponseModel: Codable {
    let id: Int?
    let name, status, species, type: String?
    let gender: String?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

