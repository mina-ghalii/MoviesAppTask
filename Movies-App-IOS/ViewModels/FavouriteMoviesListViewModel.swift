//
//  FavouriteMoviesListViewModel.swift
//  Movies-App-IOS
//
//  Created by Mina Atef on 09/04/2021.
//

import Foundation


class FavouriteMoviesListViewModel{
    func reteriveFavouriteMovies() -> [MoviesModel]{
        let movies = RealmConfig.realmConfig.reteriveFavouriteMovies()  
        return self.changeMoviesListDataType(movies:movies)
    }
    
    func changeMoviesListDataType(movies:[MoviesTable]) -> [MoviesModel]{
        var moviesArray = [MoviesModel]()
        for movie in movies {
            let movieModel = MoviesModel()
            movieModel.id = movie.id
            movieModel.originalTitle = movie.originalTitle
            movieModel.posterPath = movie.posterPath
            movieModel.voteAverage = movie.voteAverage
            movieModel.voteCount = movie.voteCount
            moviesArray.append(movieModel)
        }
        return moviesArray
    }
}
