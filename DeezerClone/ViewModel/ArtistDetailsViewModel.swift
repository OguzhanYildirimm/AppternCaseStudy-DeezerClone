//
//  ArtistDetailsViewModel.swift
//  DeezerClone
//
//  Created by Oğuzhan Yıldırım on 9.05.2023.
//

import Foundation

struct ArtistDetailsListViewModel {
    let artistDetailsViewList: [ArtistDetails]
}

extension ArtistDetailsListViewModel {
    
    func numberOfRowsInSection()-> Int {
        return self.artistDetailsViewList.count
    }
    
    func artistDetailsAtIndex(index: Int) -> ArtistDetailsViewModel  {
        let artistDetails = self.artistDetailsViewList[index]
        return ArtistDetailsViewModel(artistDetails: artistDetails)
    }
}

struct ArtistDetailsViewModel {
    let artistDetails: ArtistDetails
}

extension ArtistDetailsViewModel {
    
    var id: Int {
        return self.artistDetails.id
    }
    
    var title: String {
        return self.artistDetails.title
    }
    
    var cover: String {
        return self.artistDetails.cover
    }
    
    var coverSmall: String {
        return self.artistDetails.coverSmall
    }
    
    var coverMedium: String {
        return self.artistDetails.coverMedium
    }
    
    var coverBig: String {
        return self.artistDetails.coverBig
    }
    
    var coverXl: String {
        return self.artistDetails.coverXl
    }
    
    var releaseDate: String {
        return self.artistDetails.releaseDate
    }
    
    
}
