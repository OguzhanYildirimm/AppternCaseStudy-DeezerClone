//
//  AlbumDetailsVC.swift
//  DeezerClone
//
//  Created by Oğuzhan Yıldırım on 9.05.2023.
//

import UIKit
import AVFoundation
import CoreData

class AlbumDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var selectedArtistName = ""
    var selectedAlbumName = ""
    var selectedAlbumCoverString = ""
    var selectedAlbumId = 0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chosenAlbumLabel: UILabel!
    
    var helper = Helper()
    
    private var trackListViewModel: TrackListViewModel!
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        chosenAlbumLabel.text = selectedAlbumName
        
        
        WebService().fetchAlbumDetailsData(id: String(selectedAlbumId)) { tracks in
            if let tracks = tracks {
                self.trackListViewModel = TrackListViewModel(trackViewList: tracks)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.trackListViewModel == nil ? 0 : trackListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! AlbumDetailsTableViewCell
        let trackViewModel = trackListViewModel.trackDetailsAtIndex(index: indexPath.row)
        
        let durationInSeconds = trackViewModel.duration
        let durationInMinutes = durationInSeconds / 60
        let formattedDuration = String(format: "%d:%02d", durationInMinutes, durationInSeconds % 60)

        let trackIdString = String(trackViewModel.id)
        
        
        cell.updateLikedButton(trackId: trackIdString)
        cell.trackIdLabel.text = trackIdString
        cell.trackPreviewLabel.text = trackViewModel.preview
        cell.trackImage.sd_setImage(with: URL(string: selectedAlbumCoverString))
        cell.trackName.text = trackViewModel.title
        cell.trackDuration.text = formattedDuration
        cell.artistNameLabel.text = selectedArtistName
        cell.trackImageLabel.text = selectedAlbumCoverString
        
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trackViewModel = trackListViewModel.trackDetailsAtIndex(index: indexPath.row)
    
        let musicURLString = trackViewModel.preview
                
                guard let musicURL = URL(string: musicURLString) else {
                    return
                }
                
                player?.pause()
                
                let playerItem = AVPlayerItem(url: musicURL)
                player = AVPlayer(playerItem: playerItem)
                player?.play()
        
    }
}
