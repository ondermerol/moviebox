//
//  MovieDetailViewController.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit
import WebKit

protocol MovieDetailViewDisplayLogic: class {
    func displayMovieDetail(movieDetail: MovieDetailViewModel,
                            castMembers: CastMembersViewModel,
                            videoViewModel: VideoViewModel?)
}

class MovieDetailViewController: BaseViewControlller, MovieDetailViewDisplayLogic, WKNavigationDelegate {

    // MARK: Properties
    
    var interactor: MovieDetailViewBusinessLogic?
    var router: (NSObjectProtocol & MovieDetailViewRoutingLogic & MovieDetailViewDataPassing)?
    
    var movieDetailViewModel: MovieDetailViewModel?
    var castMembersViewModel: CastMembersViewModel?
    var videoViewModel: VideoViewModel?
    
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
        
        guard let scrollView = scrollView else {
            return
        }
        
        scrollView.backgroundColor = ColorUtility.grayLight()
        scrollView.isScrollEnabled = true
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: getTotalTopBarHeight()).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Content View
        
        let contentView = UIView()
        contentView.backgroundColor = ColorUtility.grayLight()
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let heightConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConst.priority = UILayoutPriority(250)
        heightConst.isActive = true
        
        // Name
        
        let labelName = UILabel()
        labelName.font = FontUtility.titleFont()
        labelName.textColor = ColorUtility.titleColor()
        labelName.numberOfLines = 0
        labelName.text = self.movieDetailViewModel?.title
        
        contentView.addSubview(labelName)
        
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        labelName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        labelName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        labelName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // Average Vote

        let labelAverageVote = UILabel()
        labelAverageVote.font = FontUtility.voteFont()
        labelAverageVote.textColor = ColorUtility.appTopColor()
        labelAverageVote.text = (movieDetailViewModel?.averageVote.description).stringValue + " ✭"

        contentView.addSubview(labelAverageVote)

        labelAverageVote.translatesAutoresizingMaskIntoConstraints = false
        labelAverageVote.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 2).isActive = true
        labelAverageVote.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        labelAverageVote.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10).isActive = true
        labelAverageVote.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // ImageView
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        
        contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.topAnchor.constraint(equalTo: labelAverageVote.bottomAnchor, constant: 20).isActive = true
        
        DispatchQueue.main.async {
            let url = "https://image.tmdb.org/t/p/w500" +  (self.movieDetailViewModel?.imageUrl).stringValue
            imageView.sd_setImage(with: URL(string: url),
                                       placeholderImage: UIImage(named: "avatar"))
        }
        
        // Overview
        
        let labelOverview = UILabel()
        labelOverview.font = FontUtility.descriptionFont()
        labelOverview.textColor = ColorUtility.decriptionColor()
        labelOverview.numberOfLines = 0
        labelOverview.text = self.movieDetailViewModel?.overview
        
        contentView.addSubview(labelOverview)
        
        labelOverview.translatesAutoresizingMaskIntoConstraints = false
        labelOverview.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        labelOverview.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20).isActive = true
        labelOverview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        labelOverview.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        
        // Movie Credits Title
        
        let movieCreditsLabel = UILabel()
        movieCreditsLabel.font = FontUtility.titleFont()
        movieCreditsLabel.textColor = ColorUtility.titleColor()
        movieCreditsLabel.numberOfLines = 0
        movieCreditsLabel.text = "Cast Members"
        
        contentView.addSubview(movieCreditsLabel)
        
        movieCreditsLabel.translatesAutoresizingMaskIntoConstraints = false
        movieCreditsLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40).isActive = true
        movieCreditsLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        movieCreditsLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10).isActive = true
        movieCreditsLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Collectionview
        
        var collectionview: UICollectionView!
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 150, height: 220)
        collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(MovieCastCell.self, forCellWithReuseIdentifier: "MovieCastCell")
        collectionview.showsHorizontalScrollIndicator = true
        collectionview.alwaysBounceVertical = false
        collectionview.backgroundColor = .clear
        self.view.addSubview(collectionview)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.topAnchor.constraint(equalTo: movieCreditsLabel.bottomAnchor, constant: 30).isActive = true
        collectionview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionview.heightAnchor.constraint(equalToConstant: 220).isActive = true
        collectionview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50).isActive = true
        
        collectionview.reloadData()
    }
    
    // MARK: MovieDetailViewDisplayLogic
    
    func displayMovieDetail(movieDetail: MovieDetailViewModel,
                            castMembers: CastMembersViewModel,
                            videoViewModel: VideoViewModel?) {
        
        self.movieDetailViewModel = movieDetail
        self.castMembersViewModel = castMembers
        self.videoViewModel = videoViewModel
        
        title = movieDetailViewModel?.title.stringValue
        
        setupView()
    }
    
    // MARK: Action
    
    @objc func homeButtonAction(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
