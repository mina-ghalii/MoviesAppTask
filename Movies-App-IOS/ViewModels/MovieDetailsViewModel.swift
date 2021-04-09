//
//  MovieDetailsViewModel.swift
//  Movies-App-IOS
//
//  Created by Mina Atef on 09/04/2021.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailsViewModel:SaveDeleteMoviesViewModel{
    private var movie:MoviesModel!
    var genersString:PublishRelay<String> = PublishRelay()
    var description:PublishRelay<String> = PublishRelay()
    var geners = ""
    var overview = ""
    
    init(movie:MoviesModel) {
        super.init()
        self.movie = movie
        getMovieDetails()
    }
    
    func getMovieDetails(){
        NetworkLayer.request(path: "movie/\(movie.id ?? 0)", method: .get,  model: MovieDetailsModel.self,useGenericBaseModel:false, showLoading: true) { (response, message, isDone) in
            if let movieDetails = response as? MovieDetailsModel{
                self.getGenresInString(geners: movieDetails.genres ?? [])
                self.overview = movieDetails.overview ?? ""
                self.description.accept(movieDetails.overview ?? "")
                self.showFavButton()
            }
        }
    }
    
    func showFavButton(){
        decideShowAddOrDelete(id: movie.id ?? 0)
    }
    
    func saveOrRemoveMoviePressed(){
        decideSaveOrDelete(id: movie.id ?? 0, originalTitle: movie.originalTitle ?? "", posterPath: movie.posterPath ?? "", voteCount: movie.voteCount ?? 0, voteAverage: movie.voteAverage ?? 0, genres: geners , overview: overview )
    }
    

    
    func getGenresInString(geners:[Genres]){
        
        if geners.count > 0{
            for index in 0...(geners.count - 1) {
                if index == 0{
                    self.geners.append(" \(geners[index].name ?? "") ")
                }else if index == (geners.count - 1){
                    self.geners.append("| \(geners[index].name ?? "") ")
                }else{
                    self.geners.append(" \(geners[index].name ?? "") |")
                }
            }
        }

        self.genersString.accept(self.geners)
    }
}
