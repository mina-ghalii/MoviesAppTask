//
//  MovieDetailsModel.swift
//  Movies-App-IOS
//
//  Created by Mina Atef on 09/04/2021.
//

import Foundation


class MovieDetailsModel:Codable{
    var genres:[Genres]?
    var overview:String?
}

class Genres:Codable{
    var id:Int?
    var name:String?
}
