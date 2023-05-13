//
//  ArtistDetailsModel.swift
//  DeezerClone
//
//  Created by Oğuzhan Yıldırım on 9.05.2023.
//

import Foundation

// MARK: - Welcome
struct RootArtistDetails: Decodable {
    let data: [ArtistDetails]
}

// MARK: - Datum
struct ArtistDetails: Decodable {
    let id: Int
    let title: String
    let link, cover: String
    let coverSmall, coverMedium, coverBig, coverXl: String
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case id, title, link, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case releaseDate = "release_date"

    }
}
