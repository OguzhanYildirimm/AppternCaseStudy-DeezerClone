//
//  Helper.swift
//  DeezerClone
//
//  Created by Oğuzhan Yıldırım on 11.05.2023.
//

import Foundation
import CoreData
import UIKit


class Helper {
    
    func isLikedTrack(trackId: String)-> Bool{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LikedSong")
        
        fetchRequest.predicate = NSPredicate(format: "trackId = %@", trackId)
        
        do {
                let count = try context.count(for: fetchRequest)
                return count > 0
            } catch {
                print("Veri sorgulama hatası: \(error)")
                return false
            }
    }
    
    func saveLikedTrack(trackId: String, trackTitle: String,trackDuration: String, trackPreview: String, artistName: String,trackImage: String,isLiked:Bool){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        let newLikedTrack = NSEntityDescription.insertNewObject(forEntityName: "LikedSong", into: context)
        
        newLikedTrack.setValue(trackId, forKey: "trackId")
        newLikedTrack.setValue(trackTitle, forKey: "trackName")
        newLikedTrack.setValue(trackDuration, forKey: "trackDuration")
        newLikedTrack.setValue(trackPreview, forKey: "trackPreview")
        newLikedTrack.setValue(trackImage, forKey: "trackImage")
        newLikedTrack.setValue(artistName, forKey: "artistName")
        newLikedTrack.setValue(isLiked, forKey: "isLiked")
        
        do {
            try context.save()
            print("veri eklendi")
        } catch {
            print("Hata: \(error)")
        }
        
    }
    
    func deleteLikedTrack(trackId: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LikedSong")
        
        fetchRequest.predicate = NSPredicate(format: "trackId = %@", trackId)
        
        do {
            let results = try context.fetch(fetchRequest)
            for track in results {
                // Veriyi silebilirsiniz
                context.delete(track as! NSManagedObject)
            }
        } catch {
            print("Veri silme hatası: \(error)")
        }
        
        do {
            try context.save()
            print("veri silindi")
        } catch {
            print("Değişiklikleri kaydetme hatası: \(error)")
        }
        
    }
    
    func mapToLikedTrack(from managedObject: NSManagedObject) -> LikedTrack {
        let trackId = managedObject.value(forKey: "trackId") as? String ?? ""
        let artistName = managedObject.value(forKey: "artistName") as? String ?? ""
        let trackName = managedObject.value(forKey: "trackName") as? String ?? ""
        let trackDuration = managedObject.value(forKey: "trackDuration") as? String ?? ""
        let trackImage = managedObject.value(forKey: "trackImage") as? String ?? ""
        let trackPreview = managedObject.value(forKey: "trackPreview") as? String ?? ""
        let isLiked = managedObject.value(forKey: "isLiked") as? Bool ?? false
        // Diğer özellikleri dönüştürün
        
        return LikedTrack(trackId: trackId, artistName: artistName, trackName: trackName, trackDuration: trackDuration , trackImage: trackImage , trackPreview: trackPreview , isLiked: isLiked)
    }
    
    func getLikedTracks(completion: @escaping ([LikedTrack]?)-> ()){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LikedSong")
        
        var likedTracks: [LikedTrack] = []
        
        do {
            let results = try context.fetch(fetchRequest)
            let likedTracksList = results.map { mapToLikedTrack(from: $0) }
            likedTracks = likedTracksList
            
        }catch{
            print("error")
        }
        
        completion(likedTracks)
        
    }
    
    
}
