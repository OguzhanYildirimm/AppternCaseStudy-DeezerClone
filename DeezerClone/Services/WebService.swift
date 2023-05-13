//
//  WebService.swift
//  DeezerClone
//
//  Created by Oğuzhan Yıldırım on 9.05.2023.
//

import Foundation
import Alamofire

class WebService {
    
    func fetchGenreData(completion: @escaping ([Genre]?) -> Void) {
        let url = "https://api.deezer.com/genre"
        
        AF.request(url).responseDecodable(of: RootGenre.self) { response in
            switch response.result {
            case .success(let rootGenre):
                let genreList = rootGenre.data
                completion(genreList)
            case .failure(let error):
                print("Error fetching genre data: \(error)")
                completion(nil)
            }
        }
    }
    
    func fetchArtistData(id: String, completion: @escaping ([Artist]?) -> Void) {
        let url = "https://api.deezer.com/genre/\(id)/artists"
        
        AF.request(url).responseDecodable(of: RootArtist.self) { response in
            switch response.result {
            case .success(let rootArtist):
                let artistList = rootArtist.data
                completion(artistList)
            case .failure(let error):
                print("Error fetching artist data: \(error)")
                completion(nil)
            }
        }
    }
    
    func fetchArtistDetailsData(id: String, completion: @escaping ([ArtistDetails]?) -> Void) {
        let url = "https://api.deezer.com/artist/\(id)/albums"
        
        AF.request(url).responseDecodable(of: RootArtistDetails.self) { response in
            switch response.result {
            case .success(let rootArtistDetails):
                let artistDetailsList = rootArtistDetails.data
                completion(artistDetailsList)
            case .failure(let error):
                print("Error fetching artist details data: \(error)")
                completion(nil)
            }
        }
    }
    
    func fetchAlbumDetailsData(id: String, completion: @escaping ([Track]?) -> Void) {
        let url = "https://api.deezer.com/album/\(id)/tracks"
        
        AF.request(url).responseDecodable(of: RootTrack.self) { response in
            switch response.result {
            case .success(let rootTrack):
                let albumDetailsList = rootTrack.data
                completion(albumDetailsList)
            case .failure(let error):
                print("Error fetching album details data: \(error)")
                completion(nil)
            }
        }
    }
}
