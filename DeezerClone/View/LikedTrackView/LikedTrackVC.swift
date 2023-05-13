//
//  LikedTrackVC.swift
//  DeezerClone
//
//  Created by Oğuzhan Yıldırım on 11.05.2023.
//

import UIKit
import SDWebImage
import AVFoundation

class LikedTrackVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    

    
    @IBOutlet weak var emptyLikedTrackListLabel: UILabel!
    
    private var likedTrackListViewModel: LikedTrackListViewModel!
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        
        getLikedTrackData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(getLikedTrackData), name: NSNotification.Name("LikedTrackDeleted"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getLikedTrackData), name: NSNotification.Name("LikedTrackAdded"), object: nil)
        
    }
    
    @objc func getLikedTrackData(){
        
        Helper().getLikedTracks { likedTrack in
            
            if let likedTrack = likedTrack {
                self.likedTrackListViewModel = LikedTrackListViewModel(likedTrackViewList:likedTrack )
                if self.likedTrackListViewModel.likedTrackViewList.isEmpty {
                    self.emptyLikedTrackListLabel.isHidden = false
                }else{
                    self.emptyLikedTrackListLabel.isHidden = true
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.likedTrackListViewModel == nil ? 0 : likedTrackListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikedTrackCell", for: indexPath) as! LikedTrackTableViewCell
        let likedTrackViewModel = likedTrackListViewModel.likedTrackAtIndex(index: indexPath.row)
        
        cell.pauseDeletedLikedTrack(trackId: likedTrackViewModel.trackId,player: player)
        cell.likedTrackIdLabel.text = likedTrackViewModel.trackId
        cell.updateLikedButton(trackId: likedTrackViewModel.trackId)
        cell.likedTrackImage.sd_setImage(with: URL(string: likedTrackViewModel.trackImage))
        cell.likedTrackArtistName.text = likedTrackViewModel.artistName
        cell.likedTrackName.text = likedTrackViewModel.trackName
        cell.likedTrackDuration.text = likedTrackViewModel.trackDuration
        
        return cell
    }
    
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let likedTrackViewModel = likedTrackListViewModel.likedTrackAtIndex(index: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikedTrackCell", for: indexPath) as! LikedTrackTableViewCell
        
        let musicURLString = likedTrackViewModel.trackPreview
        
        guard let musicURL = URL(string: musicURLString) else {
            return
        }
        
        player?.pause()
        
        let playerItem = AVPlayerItem(url: musicURL)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }
}
