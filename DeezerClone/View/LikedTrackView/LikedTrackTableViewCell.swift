//
//  LikedTrackTableViewCell.swift
//  DeezerClone
//
//  Created by Oğuzhan Yıldırım on 11.05.2023.
//

import UIKit
import AVFoundation

class LikedTrackTableViewCell: UITableViewCell {
    

    
    
    
    
    
    @IBOutlet weak var likedTrackButton: UIButton!
    
    @IBOutlet weak var likedTrackImage: UIImageView!
    
    @IBOutlet weak var likedTrackArtistName: UILabel!
    
    @IBOutlet weak var likedTrackName: UILabel!
    
    @IBOutlet weak var likedTrackDuration: UILabel!
    
    @IBOutlet weak var likedTrackIdLabel: UILabel!
    
    var helper = Helper()
    var player: AVPlayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func updateLikedButton(trackId: String) {
        
        let heartImage = helper.isLikedTrack(trackId: trackId) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        likedTrackButton.setImage(heartImage, for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func pauseDeletedLikedTrack(trackId: String,player: AVPlayer?){
        if helper.isLikedTrack(trackId: trackId) {
            player?.pause()
        }else{
            
        }
    }
    
    @IBAction func likedButtonClicked(_ sender: Any) {
        
        if helper.isLikedTrack(trackId: likedTrackIdLabel.text!){
            helper.deleteLikedTrack(trackId: likedTrackIdLabel.text!)
            NotificationCenter.default.post(name: NSNotification.Name("LikedTrackDeleted"), object: nil)
            NotificationCenter.default.post(name: Notification.Name("StopPlayer"), object: nil)
        }else{
            
        }
        
    }
    
    
}
