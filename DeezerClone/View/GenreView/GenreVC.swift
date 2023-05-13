//
//  GenreVC.swift
//  DeezerClone
//
//  Created by Oğuzhan Yıldırım on 9.05.2023.
//

import UIKit
import SDWebImage
import AVFoundation

class GenreVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var genreListViewModel: GenreListViewModel!
    
    var chosenGenreName: String = ""
    var chosenGenreId: Int = 0
    var player: AVPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.dataSource = self
        collectionView.delegate = self

        WebService().fetchGenreData { genres in
            if let genres = genres {
                self.genreListViewModel = GenreListViewModel(genreViewList: genres)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.genreListViewModel == nil ? 0 : self.genreListViewModel.numberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genreCell", for: indexPath) as! GenreCollectionViewCell
        let genreViewModel = self.genreListViewModel.genreAtIndex(index: indexPath.row)
        
        cell.genreLabel.text = genreViewModel.name
        cell.genreImage.sd_setImage(with: URL(string: genreViewModel.pictureMedium))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let genreViewModel = self.genreListViewModel.genreAtIndex(index: indexPath.row)
        chosenGenreName = genreViewModel.name
        chosenGenreId = genreViewModel.id
        performSegue(withIdentifier: "toArtistVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toArtistVC" {
            let destinationVC = segue.destination as! ArtistVC
            destinationVC.selectedGenreTitle = chosenGenreName
            destinationVC.selectedGenreId = chosenGenreId
        }
    }


}
