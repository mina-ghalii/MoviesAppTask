//
//  ListMoviesVC.swift
//  Movies-App-IOS
//
//  Created by Mina Atef on 08/04/2021.
//

import UIKit
import RxCocoa
import RxSwift
import UIScrollView_InfiniteScroll
import Realm
import RealmSwift


class ListMoviesVC: UIViewController {
    var listViewModel:ListMoviesBaseViewModel! 
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var searchBarHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listViewModel = ListMoviesBaseViewModel(listType: navigationController?.restorationIdentifier ?? "")
        bindMoviesWithTableView()
//        bindMoviesWithTableView()
        onMoviePressed()
        searchBarListener()
        loadMoreMovies()
        listViewModel.searchConstraintValue.bind(to: searchBarHeightConstraint.rx.constant).disposed(by: disposeBag)
        setupUI()
        
    }
    
    func setupUI(){
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        moviesTableView.infiniteScrollTriggerOffset = 500
        searchBarHeightConstraint.constant = 0
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        listViewModel.handelSearchView()
        self.moviesTableView.keyboardDismissMode = .onDrag
        
    }
    

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listViewModel.listfavourits()
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    
    func bindMoviesWithTableView(){
        listViewModel.moviesList.bind(to: (self.moviesTableView?.rx.items(cellIdentifier:MoviesListTableViewCell.reusableId ))!){
            
            _, movie,cell in
            if let moviesCell = cell as? MoviesListTableViewCell{
                moviesCell.setData(title: movie.originalTitle ?? "", movieImageUrl: movie.posterPath ?? "", rate: movie.voteAverage ?? 0.0)
            }
            
        }.disposed(by: self.disposeBag)
    }
    
    func onMoviePressed(){
        self.moviesTableView!.rx.modelSelected(MoviesModel.self).subscribe(onNext: {movie in
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIds.movieDetailsVC) as? MovieDetailsVC{
                vc.movie = movie
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }).disposed(by: disposeBag)
    }
    
  
    func loadMoreMovies(){
        moviesTableView.addInfiniteScroll { (tableView) -> Void in
            self.listViewModel.loadMoreMovies()
            self.moviesTableView.finishInfiniteScroll()
        }
    }
    
    func searchBarListener(){
        
        let search = searchBar
            .rx.text // Observable property thanks to RxCocoa
            .orEmpty// Make it non-optional
            .debounce(.milliseconds(1000), scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .filter { !$0.isEmpty }
        search.subscribe(onNext: {movieName in
            self.listViewModel.searchBy(keyword: movieName)
        }).disposed(by: disposeBag)
    }


}








