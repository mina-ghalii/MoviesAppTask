//
//  ImageViewExtension.swift
//  Movies-App-IOS
//
//  Created by Mina Atef on 08/04/2021.
//

import UIKit
import Kingfisher

extension UIImageView {

    func downloadMovieImage(url:String) -> DownloadTask? {
        let imageUrl = Constants.baseURLImages + url
        return self.kf.setImage(with: URL(string: imageUrl ))
    }

}
