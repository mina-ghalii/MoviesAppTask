//
//  ListMoviesBaseViewModel.swift
//  Movies-App-IOS
//
//  Created by Mina Atef on 08/04/2021.
//

import Foundation
import RxSwift
import RxCocoa

class ListMoviesBaseViewModel:FavouriteMoviesListViewModel{
    var moviesList:PublishRelay<[MoviesModel]> = PublishRelay()
    var prevMovies = [MoviesModel]()
    private var moviesListType : MoviesListType!
    var pageNumber = 1
    var numberOfPages:Int = 0
    var searchConstraintValue:PublishRelay<CGFloat> = PublishRelay()
    var listType = ""
    init(listType:String) {
        super.init()
        moviesListType = MoviesListType(rawValue: listType)
        if MoviesListType.nowPlaying == moviesListType{
            getMovies(type: Constants.nowPlaying)
            self.listType = Constants.nowPlaying
        }else if MoviesListType.topRated == moviesListType{
            getMovies(type: Constants.topRated)
            self.listType = Constants.topRated
        }else if MoviesListType.search == moviesListType{
            searchConstraintValue.accept(55)
        }else{
            moviesListType = .favMovies
            listfavourits()
            
        }
    }
    
    func listfavourits(){
        if moviesListType == .favMovies{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.prevMovies = self.reteriveFavouriteMovies()
                self.moviesList.accept(self.prevMovies)
            }
        }
        
    }
    
    func handelSearchView(){
        if MoviesListType.search == moviesListType{
            searchConstraintValue.accept(55)
        }
    }
    
    func searchBy(keyword:String){
        let searchExtension = Constants.search + keyword
        getMovies(type:searchExtension)
    }
    
    
    
    func getMovies(type:String){
        
        NetworkLayer.request(path: type,pageNumber:pageNumber, method: .get,  model: [MoviesModel].self, showLoading: true) { (response, message, isDone) in
            if isDone ?? false{
//                let x = self.reteriveFavouriteMovies()
                
//                self.moviesList.accept(x)

                if let moviesResponse = response as? BaseModel<[MoviesModel]>{
                    if moviesResponse.results?.count ?? 0 > 0{
                        if self.moviesListType == .search{
                            self.moviesList.accept(moviesResponse.results ?? [])
                        }else{
                            self.prevMovies.append(contentsOf: moviesResponse.results ?? [])
                            self.moviesList.accept(self.prevMovies)
                        }
                        
                        self.numberOfPages = moviesResponse.totalPages ?? 0
                    }else{
                        Alert.show(message: "No Movies")
                    }

                }
                
            }
        }
    }
    
    
    
    func loadMoreMovies(){
        if pageNumber == numberOfPages{
            return
        }
        if moviesListType != .favMovies{
            pageNumber += 1
            getMovies(type:listType)
        }
        
    }
    
}
