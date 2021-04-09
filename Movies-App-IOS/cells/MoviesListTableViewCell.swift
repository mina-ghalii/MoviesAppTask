//
//  MoviesListTableViewCell.swift
//  Movies-App-IOS
//
//  Created by Mina Atef on 08/04/2021.
//

import UIKit
import Kingfisher

class MoviesListTableViewCell: UITableViewCell {

    static let reusableId = "movieCell"

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var rate: UILabel!
    
    func setData(title:String,movieImageUrl:String,rate:Double){
        self.title.text = title
        self.movieImage.downloadMovieImage(url: movieImageUrl)
        self.rate.text = "Rate: \(rate)/10"
        
    }
}
