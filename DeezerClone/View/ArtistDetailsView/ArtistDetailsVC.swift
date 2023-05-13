//
//  ArtistDetailsVC.swift
//  DeezerClone
//
//  Created by Oğuzhan Yıldırım on 9.05.2023.
//

import UIKit

class ArtistDetailsVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var selectedArtistId = 0
    var selectedArtistName = ""
    var selectedArtistImageString = ""
    
    var chosenAlbumId = 0
    var chosenAlbumName = ""
    var chosenAlbumCoverString = ""
    var chosenArtistName = ""
    
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chosenArtistLabel: UILabel!
    @IBOutlet weak var chosenArtistImage: UIImageView!
    private var artistDetailsListViewModel: ArtistDetailsListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        chosenArtistLabel.text = selectedArtistName
        chosenArtistImage.sd_setImage(with: URL(string: selectedArtistImageString))
       
        
        
        WebService().fetchArtistDetailsData(id: String(selectedArtistId)) { artistDetails in
            if let artistDetails = artistDetails {
                self.artistDetailsListViewModel = ArtistDetailsListViewModel(artistDetailsViewList: artistDetails)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artistDetailsListViewModel == nil ? 0 : self.artistDetailsListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! ArtistDetailsTableViewCell
        let artistDetailsViewModel = self.artistDetailsListViewModel.artistDetailsAtIndex(index: indexPath.row)
        
        cell.artistImage.sd_setImage(with: URL(string: artistDetailsViewModel.coverMedium))
        cell.albumNameLabel.text = artistDetailsViewModel.title
        cell.AlbumReleaseDateLabel.text = "Çıkış tarihi : \(artistDetailsViewModel.releaseDate)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artistDetailsListViewModel = self.artistDetailsListViewModel.artistDetailsAtIndex(index: indexPath.row)
        chosenAlbumId = artistDetailsListViewModel.id
        chosenAlbumName = artistDetailsListViewModel.title
        chosenAlbumCoverString = artistDetailsListViewModel.coverMedium
        chosenArtistName = selectedArtistName
        performSegue(withIdentifier: "toAlbumDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlbumDetailsVC" {
            let destinationVC = segue.destination as! AlbumDetailsVC
            destinationVC.selectedAlbumId = chosenAlbumId
            destinationVC.selectedAlbumName = chosenAlbumName
            destinationVC.selectedAlbumCoverString = chosenAlbumCoverString
            destinationVC.selectedArtistName = chosenArtistName
        }
    }

}
