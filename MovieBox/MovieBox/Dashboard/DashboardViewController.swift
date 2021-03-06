//
//  DashboardViewController.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit

protocol DashboardViewDisplayLogic: class {
    func displayPopularMovies(movieListViewModel: MovieListViewModel, genreViewModel: GenreViewModel?)
    func displayBothSearchedPeopleAndMovie(movieListViewModel: MovieListViewModel,
                                           peopleListViewModel: PeopleListViewModel)
}

class DashboardViewController: BaseViewControlller, DashboardViewDisplayLogic {

    // MARK: Properties
    
    var interactor: DashboardViewBusinessLogic?
    var router: (NSObject & DashboardViewRoutingLogic & DashboardViewDataPassing)?
    
    var movieListViewModel: MovieListViewModel?
    var searchedMovieListViewModel: MovieListViewModel?
    var searchedPeopleListViewModel: PeopleListViewModel?
    var genreViewModel: GenreViewModel?
    var hasActivePaginationServiceCall: Bool = false
    
    var isSearching: Bool = false
    var searchText: String?
    
    var collectionView: UICollectionView?
    var searchBar: UISearchBar?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies & People"
        
        setupCollectionView()
        
        interactor?.getPopularMovies(forpage: 1)
    }
    
    // MARK: Setup
  
    private func setup() {
        let viewController = self
        let interactor = DashboardViewInteractor()
        let presenter = DashboardViewPresenter()
        let router = DashboardViewRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        collectionView.register(PersonCell.self, forCellWithReuseIdentifier: "PersonCell")
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(ActivityIndicatorCell.self, forCellWithReuseIdentifier: "ActivityIndicatorCell")
        collectionView.showsVerticalScrollIndicator = true
    }
    
    private func setupCollectionView() {
        
        let totalBarHeight = getTotalTopBarHeight()
        
        searchBar = UISearchBar(frame: .zero)
        guard let searchBar = searchBar else {
            return
        }
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search movies or person"
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = ColorUtility.appTopColor()
        searchBar.setupSearchBar(background: ColorUtility.appTopColor(), inputText: .white, placeholderText: .lightGray, image: .white)
        searchBar.delegate = self
        
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: totalBarHeight).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: view.topAnchor, constant: totalBarHeight + 60).isActive = true
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = ColorUtility.appViewColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: totalBarHeight + 60).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    // MARK: DashboardViewDisplayLogic
    
    func displayPopularMovies(movieListViewModel: MovieListViewModel, genreViewModel: GenreViewModel?) {
        
        if self.movieListViewModel == nil || self.movieListViewModel?.items?.count == 0 {
            self.movieListViewModel = movieListViewModel
        } else if movieListViewModel.items != nil {
            self.movieListViewModel?.items?.append(contentsOf: movieListViewModel.items!)
        }
        
        self.genreViewModel = genreViewModel
        
        updateMovieListViewModelForGenreString()
        
        hasActivePaginationServiceCall = false
        collectionView?.reloadData()
    }
    
    func displayBothSearchedPeopleAndMovie(movieListViewModel: MovieListViewModel,
                                           peopleListViewModel: PeopleListViewModel) {
        
        self.searchedMovieListViewModel = movieListViewModel
        self.searchedPeopleListViewModel = peopleListViewModel
        
        updateSearchedMovieListViewModelForGenreString()
        
        isSearching = true
        hasActivePaginationServiceCall = false
        collectionView?.setContentOffset(.zero, animated: false)
        collectionView?.reloadData()
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar?.endEditing(true)
    }
    
    // MARK: Private Helpers - Genre String Creation
    
    private func updateMovieListViewModelForGenreString() {
        
        guard let movieListViewModel = self.movieListViewModel, let _ = movieListViewModel.items else {
            return
        }
        
        for (i, item) in movieListViewModel.items!.enumerated() {
            self.movieListViewModel?.items?[i].genreString = getGenreString(genreList: item.genreIds ?? [])
        }
    }
    
    private func updateSearchedMovieListViewModelForGenreString() {
        
        guard let searchedMovieListViewModel = self.searchedMovieListViewModel, let _ = searchedMovieListViewModel.items else {
            return
        }
        
        for (i, item) in searchedMovieListViewModel.items!.enumerated() {
            self.searchedMovieListViewModel?.items?[i].genreString = getGenreString(genreList: item.genreIds ?? [])
        }
    }
    
    private func getGenreString(genreList: [Int]) -> String? {
        var resultStr: String?
        var filteredArray: [String] = []
        
        for genreId in genreList {
            
            if let name = self.genreViewModel?.genres?.filter({$0.id == genreId}).first?.name {
                filteredArray.append(name)
            }
        }
        
        for (index, name) in filteredArray.enumerated() {
            
            if index == 0 {
                resultStr = name
            } else {
                resultStr = resultStr.stringValue + ", " + name
            }
        }
        
        return resultStr
    }
}
