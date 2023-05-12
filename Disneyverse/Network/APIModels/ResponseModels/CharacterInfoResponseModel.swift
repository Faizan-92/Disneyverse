//
//  CharacterInfoResponseModel.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation

// MARK: - CharacterInfoResponseModel
struct CharacterInfoResponseModel: Codable {
    let pageInfo: PageInfo?
    let data: [CharacterInfo]?

    enum CodingKeys: String, CodingKey {
        case pageInfo = "info"
        case data
    }
}

// MARK: - CharacterInfo
struct CharacterInfo: Codable {
    let films: [String]?
    let videoGames: [String]?
    let sourceUrl: String?
    let name: String?
    let imageUrl: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case films
        case videoGames
        case sourceUrl
        case name
        case imageUrl
        case url
    }
}

// MARK: - PageInfo
struct PageInfo: Codable {
    let count, totalPages: Int?
    let previousPage, nextPage: String?
}
