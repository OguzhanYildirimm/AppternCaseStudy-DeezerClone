//
//  AlbumDetailsModel.swift
//  DeezerClone
//
//  Created by Oğuzhan Yıldırım on 9.05.2023.
//

import Foundation

// MARK: - RootTrack
struct RootTrack: Decodable {
    let data: [Track]
}

// MARK: - Track
struct Track: Decodable {
    let id: Int
    let title: String
    let duration: Int
    let preview: String

    enum CodingKeys: String, CodingKey {
        case id,title
        case duration
        case preview
    }
}
