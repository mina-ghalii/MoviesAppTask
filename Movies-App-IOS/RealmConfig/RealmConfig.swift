//
//  RealmConfig.swift
//  Movies-App-IOS
//
//  Created by Mina Atef on 09/04/2021.
//

import Foundation
import RealmSwift
//import Realm

class RealmConfig
{
    static let realmConfig = RealmConfig()
    let realm:Realm!
    
    init() {
        let config = Realm.Configuration(schemaVersion: 1, migrationBlock: { migration, oldSchemaVersion in
            
            if (oldSchemaVersion < 1) {
            }
            
        })
        
        Realm.Configuration.defaultConfiguration = config
        
        _ = try! Realm()

        realm = try! Realm()
    }
    
    func addMovieToFavoutits(id:Int,originalTitle:String, posterPath:String, voteCount:Int, voteAverage:Double, genres:String, overview:String) -> Bool{
        let movie = MoviesTable()
        movie.id = id
        movie.originalTitle = originalTitle
        movie.posterPath = posterPath
        movie.voteCount = voteCount
        movie.voteAverage = voteAverage
        movie.genres = genres
        movie.overview = overview

        do {
            try realm.write {
                realm.add(movie)
            }
            return true
        } catch let error as NSError {
            return false
          // handle error
        }

    }
    
    
    func deleteMovie(movieId:Int) -> Bool{
        
        let movieToDelete = realm.objects(MoviesTable.self).filter("id = \(movieId)")
        
        try! realm.write {
            realm.delete(movieToDelete)
        }
        return true
        
    }
    
    func movieSavedBefore(movieId:Int) -> Bool{
        
        let movie = realm.objects(MoviesTable.self).filter("id = \(movieId)")
        
        if movie.count > 0{
            return true
        }else{
            return false
        }
       
        
    }
    
    func reteriveFavouriteMovies() -> [MoviesTable]{
        let favMovies = realm.objects(MoviesTable.self)
        if favMovies.count > 0{
            let favMoviesArray = Array(favMovies)
            return favMoviesArray
        }else{
            return []
        }
        
    }
    
}
