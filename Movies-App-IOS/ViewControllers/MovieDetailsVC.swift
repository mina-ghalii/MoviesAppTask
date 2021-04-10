//
//  MoiveDetailsVC.swift
//  Movies-App-IOS
//
//  Created by Mina Atef on 09/04/2021.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailsVC: UIViewController {
    var movie:MoviesModel!
    var movieDetailsViewModel :MovieDetailsViewModel!
    
    @IBOutlet weak var gradiantView: GradientView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieSecondaryImage: UIImageView!
    @IBOutlet weak var voteCount: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    var disposeBag = DisposeBag()
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var genersLabel: UILabel!
    
    @IBOutlet weak var addAndRemoveBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    override func viewDidAppear(_ animated: Bool) {
        movieDetailsViewModel = MovieDetailsViewModel(movie: movie)
        movieDetailsViewModel.genersString.bind(to: genersLabel.rx.text).disposed(by: disposeBag)
        movieDetailsViewModel.description.bind(to: descriptionLabel.rx.text).disposed(by: disposeBag)
        movieDetailsViewModel.showFavBtn.bind(to: addAndRemoveBtn.rx.isHidden).disposed(by: disposeBag)
        movieDetailsViewModel.addOrRemoveBtnTitle.bind(to: addAndRemoveBtn.rx.title()).disposed(by: disposeBag)
    }
    
   
    
    func setupUI(){
        movieImageView.downloadMovieImage(url: movie.posterPath ?? "")
        movieSecondaryImage.image = movieImageView.image
        movieTitle.text = movie.originalTitle
        voteCount.text = "Vote count: \(movie.voteCount ?? 0)"
        rate.text = "Rate: \( movie.voteAverage ?? 0)"
        addAndRemoveBtn.isHidden = true
        
    }
    
    
    @IBAction func addAndRemoveBtnPressed(_ sender: Any) {
        movieDetailsViewModel.saveOrRemoveMoviePressed()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    

  

}


