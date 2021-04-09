//
//  RealmModels.swift
//  Movies-App-IOS
//
//  Created by Mina Atef on 09/04/2021.
//

import Foundation
import RealmSwift

class MoviesTable:Object{
    @objc dynamic var id = 0
    @objc dynamic var originalTitle = ""
    @objc dynamic var posterPath = ""
    @objc dynamic var voteCount = 0
    @objc dynamic var voteAverage = 0.0
    @objc dynamic var genres = ""
    @objc dynamic var overview = ""
}
