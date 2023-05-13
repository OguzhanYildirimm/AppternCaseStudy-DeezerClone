//
//  ArtistVC.swift
//  DeezerClone
//
//  Created by Oğuzhan Yıldırım on 9.05.2023.
//

import UIKit

class ArtistVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    var selectedGenreTitle = ""
    var selectedGenreId = 0
    
    var chosenArtistId: Int = 0
    var chosenArtistName: String = ""
    var chosenArtistImageString: String = ""
    
    private var artistListViewModel: ArtistListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        categoryTitleLabel.text = selectedGenreTitle
        
        WebService().fetchArtistData(id: String(selectedGenreId)) { artists in
            
            if let artists = artists {
                self.artistListViewModel = ArtistListViewModel(artistViewList: artists)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.artistListViewModel == nil ? 0 : self.artistListViewModel.numberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "artistCell", for: indexPath) as! ArtistCollectionViewCell
        let artistViewModel = self.artistListViewModel.artistAtIndex(index: indexPath.row)
        
        cell.artistLabel.text = artistViewModel.name
        cell.artistImage.sd_setImage(with: URL(string: artistViewModel.pictureMedium))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let artistViewModel = self.artistListViewModel.artistAtIndex(index: indexPath.row)
        chosenArtistId = artistViewModel.id
        chosenArtistName = artistViewModel.name
        chosenArtistImageString = artistViewModel.pictureMedium
        performSegue(withIdentifier: "toArtistDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toArtistDetailsVC" {
            let destinationVC = segue.destination as! ArtistDetailsVC
            destinationVC.selectedArtistId = chosenArtistId
            destinationVC.selectedArtistName = chosenArtistName
            destinationVC.selectedArtistImageString = chosenArtistImageString
        }
    }
    
}
