//
//  MovieDetailViewController.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit

protocol MovieDetailViewDisplayLogic: class {
    func displayMovieDetail(movieDetail: MovieDetailViewModel, castMembers: CastMembersViewModel)
}

class MovieDetailViewController: BaseViewControlller, MovieDetailViewDisplayLogic {

    // MARK: Properties
    
    var interactor: MovieDetailViewBusinessLogic?
    var router: (NSObjectProtocol & MovieDetailViewRoutingLogic & MovieDetailViewDataPassing)?
    
    var movieDetailViewModel: MovieDetailViewModel?
    var castMembersViewModel: CastMembersViewModel?
    
    var scrollView: UIScrollView?
    
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
        title = "Movie Detail"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let id = router?.dataStore?.movieId {
            interactor?.getMoviewDetail(forMoviewId: id)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
  
    // MARK: Setup
  
    private func setup() {
        let viewController = self
        let interactor = MovieDetailViewInteractor()
        let presenter = MovieDetailViewPresenter()
        let router = MovieDetailViewRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupView() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Home",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(homeButtonAction))
        
        // ScrollView
        
        scrollView = UIScrollView(frame: .zero)
        
        var contentSizeHeight: CGFloat = 0
        
        guard let scrollView = scrollView else {
            return
        }
        
        scrollView.backgroundColor = .systemPink
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: getTotalTopBarHeight()).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentSizeHeight = contentSizeHeight + getTotalTopBarHeight()
        
        // ImageView
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        
        scrollView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
        
        DispatchQueue.main.async {
            let url = "https://image.tmdb.org/t/p/w500" +  (self.movieDetailViewModel?.imageUrl).stringValue
            imageView.sd_setImage(with: URL(string: url),
                                       placeholderImage: UIImage(named: "movie"))
        }
        
        contentSizeHeight = contentSizeHeight + 200 + 50
        
        // Collectionview
        
        var collectionview: UICollectionView!
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 150, height: 300)
        collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(MovieCastCell.self, forCellWithReuseIdentifier: "MovieCastCell")
        collectionview.showsHorizontalScrollIndicator = true
        collectionview.backgroundColor = UIColor.white
        self.view.addSubview(collectionview)
        
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50).isActive = true
        collectionview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionview.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        collectionview.reloadData()
        
        contentSizeHeight = contentSizeHeight + 300 + 50
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentSizeHeight)
    }
    
    // MARK: MovieDetailViewDisplayLogic
    
    func displayMovieDetail(movieDetail: MovieDetailViewModel, castMembers: CastMembersViewModel) {
        movieDetailViewModel = movieDetail
        castMembersViewModel = castMembers
        
        setupView()
    }
    
    // MARK: Action
    
    @objc func homeButtonAction(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
