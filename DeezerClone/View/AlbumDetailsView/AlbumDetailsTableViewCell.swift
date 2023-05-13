//
//  AlbumDetailsTableViewCell.swift
//  DeezerClone
//
//  Created by Oğuzhan Yıldırım on 9.05.2023.
//

import UIKit
import CoreData

class AlbumDetailsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var trackImage: UIImageView!
    
    @IBOutlet weak var trackName: UILabel!
    
    @IBOutlet weak var trackDuration: UILabel!
    
    @IBOutlet weak var artistNameLabel: UILabel!
    
    @IBOutlet weak var trackPreviewLabel: UILabel!
    
    @IBOutlet weak var trackIdLabel: UILabel!
    
    @IBOutlet weak var trackImageLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    var helper = Helper()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func updateLikedButton(trackId: String) {
        
        let heartImage = helper.isLikedTrack(trackId: trackId) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        likeButton.setImage(heartImage, for: .normal)
    }
    
    @IBAction func likedButtonClicked(_ sender: Any) {
        
        if helper.isLikedTrack(trackId: trackIdLabel.text!){
            helper.deleteLikedTrack(trackId: trackIdLabel.text!)
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            NotificationCenter.default.post(name: NSNotification.Name("LikedTrackDeleted"), object: nil)
        }else{
            helper.saveLikedTrack(trackId: trackIdLabel.text!, trackTitle: trackName.text!, trackDuration: trackDuration.text!, trackPreview: trackPreviewLabel.text!, artistName: artistNameLabel.text!, trackImage: trackImageLabel.text!,isLiked: true)
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            NotificationCenter.default.post(name: NSNotification.Name("LikedTrackAdded"), object: nil)
        }
        
        
        
    }
}
