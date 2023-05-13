import Foundation

// MARK: - RootGenre
struct RootGenre: Decodable {
    let data: [Genre]
}

// MARK: - Genre
struct Genre: Decodable {
    let id: Int
    let name: String
    let picture: String
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String

    enum CodingKeys: String, CodingKey {
        case id, name, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
    }
}

