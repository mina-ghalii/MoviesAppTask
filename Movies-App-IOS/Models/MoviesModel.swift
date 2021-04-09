//
//  MoviesModel.swift
//  Movies-App-IOS
//
//  Created by Mina Atef on 08/04/2021.
//

import Foundation

class MoviesModel:Codable{
    var id:Int?
    var posterPath:String?
    var originalTitle:String?
    var voteAverage:Double?
    var voteCount:Int?
    private enum CodingKeys: String, CodingKey {
            case posterPath = "poster_path", originalTitle = "original_title",voteAverage = "vote_average",voteCount = "vote_count",id = "id"
        }
}
