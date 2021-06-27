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
    var router: (NSObjectProtocol & DashboardViewRoutingLogic & DashboardViewDataPassing)?
    
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
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        cv.register(PersonCell.self, forCellWithReuseIdentifier: "PersonCell")
        cv.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        cv.register(ActivityIndicatorCell.self, forCellWithReuseIdentifier: "ActivityIndicatorCell")
        collectionView = cv
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
        
        if self.movieListViewModel == nil || self.movieListViewModel?.items.count == 0 {
            self.movieListViewModel = movieListViewModel
        } else {
            self.movieListViewModel?.items.append(contentsOf: movieListViewModel.items)
        }
        
        self.genreViewModel = genreViewModel
        
        hasActivePaginationServiceCall = false
        collectionView?.reloadData()
    }
    
    func displayBothSearchedPeopleAndMovie(movieListViewModel: MovieListViewModel,
                                           peopleListViewModel: PeopleListViewModel) {
        
        self.searchedMovieListViewModel = movieListViewModel
        self.searchedPeopleListViewModel = peopleListViewModel
        
        isSearching = true
        hasActivePaginationServiceCall = false
        collectionView?.setContentOffset(.zero, animated: false)
        collectionView?.reloadData()
    }
}
