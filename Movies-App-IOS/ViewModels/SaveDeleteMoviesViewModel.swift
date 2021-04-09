//
//  SaveDeleteMoviesViewModel.swift
//  Movies-App-IOS
//
//  Created by Mina Atef on 09/04/2021.
//

import Foundation
import RxCocoa
import RxSwift

class SaveDeleteMoviesViewModel{
    var showFavBtn:PublishRelay<Bool> = PublishRelay()
    var addOrRemoveBtnTitle:PublishRelay<String> = PublishRelay()
    var addOrRemoveBtnColor:PublishRelay<UIColor> = PublishRelay()
    var foundBefore = false
    
    func decideSaveOrDelete(id: Int, originalTitle: String, posterPath: String, voteCount: Int, voteAverage: Double, genres: String, overview: String){
        if foundBefore{
            removeFromFavourits(id:id)
            
        }else{
            addMovieToFavourits(id: id, originalTitle: originalTitle, posterPath: posterPath, voteCount: voteCount, voteAverage: voteAverage, genres: genres, overview: overview)
            
        }
    }
    
    
    func decideShowAddOrDelete(id:Int){
        self.foundBefore = foundBefore(id: id)
        if self.foundBefore{
            showFavBtn.accept(false)
            addOrRemoveBtnTitle.accept("Remove from favourits")
            addOrRemoveBtnColor.accept(.red)
        }else{
            showFavBtn.accept(false)
            addOrRemoveBtnTitle.accept("Add to favourits")
            addOrRemoveBtnColor.accept(.systemBlue)
            
        }
    }

    func addMovieToFavourits(id: Int, originalTitle: String, posterPath: String, voteCount: Int, voteAverage: Double, genres: String, overview: String){
        if RealmConfig.realmConfig.addMovieToFavoutits(id: id, originalTitle: originalTitle, posterPath: posterPath, voteCount: voteCount, voteAverage: voteAverage, genres: genres, overview: overview){
            Alert.show(message: "Added to favourits")
            addOrRemoveBtnTitle.accept("Remove from favourits")
            self.foundBefore = true
        }
    }
    
    func removeFromFavourits(id:Int){
        if RealmConfig.realmConfig.deleteMovie(movieId:id){
            Alert.show(message: "Removed from favourits")
            addOrRemoveBtnTitle.accept("Add to favourits")
            self.foundBefore = false
        }
    }
    
    
    func foundBefore(id:Int) -> Bool{
        if RealmConfig.realmConfig.movieSavedBefore(movieId: id){
            return true
        }else{
            return false
        }
    }
    
}


