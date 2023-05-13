//
//  GenresViewModel.swift
//  DeezerClone
//
//  Created by Oğuzhan Yıldırım on 9.05.2023.
//

import Foundation

struct GenreListViewModel {
    let genreViewList: [Genre]
}

extension GenreListViewModel {
    
    func numberOfRowsInSection()-> Int {
        return self.genreViewList.count
    }
    
    func genreAtIndex(index: Int) -> GenreViewModel  {
        let genre = self.genreViewList[index]
        return GenreViewModel(genre: genre)
    }
}

struct GenreViewModel {
    let genre: Genre
}

extension GenreViewModel {
    
    var id: Int {
        return self.genre.id
    }
    
    var name: String {
        return self.genre.name
    }
    
    var picture: String {
        return self.genre.picture
    }
    
    var pictureSmall: String {
        return self.genre.pictureSmall
    }
    
    var pictureMedium: String {
        return self.genre.pictureMedium
    }
    
    var pictureBig: String {
        return self.genre.pictureBig
    }
    
    var pictureXl: String {
        return self.genre.pictureXl
    }
    
}
