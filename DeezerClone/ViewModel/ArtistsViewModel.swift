//
//  ArtistsViewModel.swift
//  DeezerClone
//
//  Created by Oğuzhan Yıldırım on 9.05.2023.
//

import Foundation

struct ArtistListViewModel {
    let artistViewList: [Artist]
}

extension ArtistListViewModel {
    
    func numberOfRowsInSection()-> Int {
        return self.artistViewList.count
    }
    
    func artistAtIndex(index: Int) -> ArtistViewModel  {
        let artist = self.artistViewList[index]
        return ArtistViewModel(artist: artist)
    }
}

struct ArtistViewModel {
    let artist: Artist
}

extension ArtistViewModel {
    
    var id: Int {
        return self.artist.id
    }
    
    var name: String {
        return self.artist.name
    }
    
    var picture: String {
        return self.artist.picture
    }
    
    var pictureSmall: String {
        return self.artist.pictureSmall
    }
    
    var pictureMedium: String {
        return self.artist.pictureMedium
    }
    
    var pictureBig: String {
        return self.artist.pictureBig
    }
    
    var pictureXl: String {
        return self.artist.pictureXl
    }
    
    
}
