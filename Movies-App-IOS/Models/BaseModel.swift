//
//  BaseModel.swift
//  Movies-App-IOS
//
//  Created by Mina Atef on 08/04/2021.
//

import Foundation

class BaseModel<T:Codable>:Codable{
    var page:Int?
    var results:T?
    var totalPages:Int?
    private enum CodingKeys: String, CodingKey {
            case page = "page", results = "results", totalPages = "total_pages"
        }
}
