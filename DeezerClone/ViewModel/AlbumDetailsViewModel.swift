//
//  AlbumDetailsViewModel.swift
//  DeezerClone
//
//  Created by Oğuzhan Yıldırım on 9.05.2023.
//

import Foundation

struct TrackListViewModel {
    let trackViewList: [Track]
}

extension TrackListViewModel {
    
    func numberOfRowsInSection()-> Int {
        return self.trackViewList.count
    }
    
    func trackDetailsAtIndex(index: Int) -> TrackViewModel  {
        let track = self.trackViewList[index]
        return TrackViewModel(track: track)
    }
}

struct TrackViewModel {
    let track: Track
}

extension TrackViewModel {
    
    var id: Int {
        return self.track.id
    }
    
    var title: String {
        return self.track.title
    }
    
    var duration: Int {
        return self.track.duration
    }
    
    var preview: String {
        return self.track.preview
    }
    

}
