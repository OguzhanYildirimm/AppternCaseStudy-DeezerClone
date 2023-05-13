//
//  LikedTrackViewModel.swift
//  DeezerClone
//
//  Created by Oğuzhan Yıldırım on 11.05.2023.
//

import Foundation

struct LikedTrackListViewModel {
    let likedTrackViewList: [LikedTrack]
}

extension LikedTrackListViewModel {
    
    func numberOfRowsInSection() -> Int{
        return self.likedTrackViewList.count
    }
    
    func likedTrackAtIndex(index: Int) -> LikedTrackViewModel {
        let likedTrack = self.likedTrackViewList[index]
        return LikedTrackViewModel(likedTrack: likedTrack)
    }
    
}


struct LikedTrackViewModel{
    let likedTrack: LikedTrack
}

extension LikedTrackViewModel {
    
    var trackId: String{
        return self.likedTrack.trackId
    }
    
    var artistName: String{
        return self.likedTrack.artistName
    }
    
    var trackName: String{
        return self.likedTrack.trackName
    }
    
    var trackDuration: String{
        return self.likedTrack.trackDuration
    }
    
    var trackImage: String{
        return self.likedTrack.trackImage
    }
    
    var trackPreview: String{
        return self.likedTrack.trackPreview
    }
    
    var isLiked: Bool{
        return self.likedTrack.isLiked
    }
}
