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
    var router: (NSObject & MovieDetailViewRoutingLogic & MovieDetailViewDataPassing)?
    
    var movieDetailViewModel: MovieDetailViewModel?
    var castMembersViewModel: CastMembersViewModel?
    var videoViewModel: VideoViewModel?
    
    var scrollView: UIScrollView?
    var collectionviewForVideos: UICollectionView?
    var collectionviewForCredits: UICollectionView?
    
    var labelName: UILabel?
    var labelAverageVote: UILabel?
    var imageView: UIImageView?
    var labelOverview: UILabel?
    var labelVideosTitle: UILabel?
    var movieCreditsTitle: UILabel?
    
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
        
        setupView()
        
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
        scrollView.tag = 100
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: getTotalTopBarHeight()).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Content View
        
        let contentView = UIView()
        contentView.backgroundColor = ColorUtility.grayLight()
        contentView.tag = 101
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
        
        labelName = UILabel()
        
        guard let labelName = labelName else {
            return
        }
        
        labelName.font = FontUtility.titleFont()
        labelName.textColor = ColorUtility.titleColor()
        labelName.numberOfLines = 0
        
        contentView.addSubview(labelName)
        
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        labelName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        labelName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        labelName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // Average Vote

        labelAverageVote = UILabel()
        
        guard let labelAverageVote = labelAverageVote else {
            return
        }
        
        labelAverageVote.font = FontUtility.voteFont()
        labelAverageVote.textColor = ColorUtility.appTopColor()

        contentView.addSubview(labelAverageVote)

        labelAverageVote.translatesAutoresizingMaskIntoConstraints = false
        labelAverageVote.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 2).isActive = true
        labelAverageVote.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        labelAverageVote.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10).isActive = true
        labelAverageVote.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        // ImageView
        
        imageView = UIImageView()
        
        guard let imageView = imageView else {
            return
        }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        
        contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.topAnchor.constraint(equalTo: labelAverageVote.bottomAnchor, constant: 20).isActive = true
        
        // Overview
        
        self.labelOverview = UILabel()
        
        guard let labelOverview = labelOverview else {
            return
        }
        
        labelOverview.font = FontUtility.descriptionFont()
        labelOverview.textColor = ColorUtility.decriptionColor()
        labelOverview.numberOfLines = 0
        
        contentView.addSubview(labelOverview)
        
        labelOverview.translatesAutoresizingMaskIntoConstraints = false
        labelOverview.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        labelOverview.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20).isActive = true
        labelOverview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        labelOverview.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(overViewAction))
        labelOverview.isUserInteractionEnabled = true
        labelOverview.addGestureRecognizer(tap)
        
        // Trailer Videos title
            
        labelVideosTitle = UILabel()
        
        guard let labelVideosTitle = labelVideosTitle else {
            return
        }
        
        labelVideosTitle.font = FontUtility.titleFont()
        labelVideosTitle.textColor = ColorUtility.titleColor()
            
        contentView.addSubview(labelVideosTitle)
            
        labelVideosTitle.translatesAutoresizingMaskIntoConstraints = false
        labelVideosTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40).isActive = true
        labelVideosTitle.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        labelVideosTitle.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10).isActive = true
        labelVideosTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
        // Trailer Videos Collectionview
            
        let layoutForVideoCollectionView: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layoutForVideoCollectionView.scrollDirection = .horizontal
        layoutForVideoCollectionView.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layoutForVideoCollectionView.itemSize = CGSize(width: 150, height: 120)
        collectionviewForVideos = UICollectionView(frame: self.view.frame, collectionViewLayout: layoutForVideoCollectionView)
            
        guard let collectionviewForVideos = collectionviewForVideos else {
            return
        }
        
        collectionviewForVideos.dataSource = self
        collectionviewForVideos.delegate = self
        collectionviewForVideos.register(VideoCell.self, forCellWithReuseIdentifier: "VideoCell")
        collectionviewForVideos.showsHorizontalScrollIndicator = false
        collectionviewForVideos.showsVerticalScrollIndicator = false
        collectionviewForVideos.alwaysBounceVertical = false
        collectionviewForVideos.backgroundColor = .clear
        collectionviewForVideos.tag = 102
        self.view.addSubview(collectionviewForVideos)
        collectionviewForVideos.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionviewForVideos.translatesAutoresizingMaskIntoConstraints = false
        collectionviewForVideos.topAnchor.constraint(equalTo: labelVideosTitle.bottomAnchor, constant: 30).isActive = true
        collectionviewForVideos.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionviewForVideos.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionviewForVideos.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        // Movie Credits Title
        
        movieCreditsTitle = UILabel()
        
        guard let movieCreditsTitle = movieCreditsTitle else {
            return
        }
        
        movieCreditsTitle.font = FontUtility.titleFont()
        movieCreditsTitle.textColor = ColorUtility.titleColor()
        movieCreditsTitle.numberOfLines = 0
        
        contentView.addSubview(movieCreditsTitle)
        
        movieCreditsTitle.translatesAutoresizingMaskIntoConstraints = false
        movieCreditsTitle.topAnchor.constraint(equalTo: collectionviewForVideos.bottomAnchor, constant: 40).isActive = true
        movieCreditsTitle.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        movieCreditsTitle.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10).isActive = true
        movieCreditsTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Moview Credits Collectionview
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 150, height: 220)
        collectionviewForCredits = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        if let collectionviewForCredits = collectionviewForCredits {
            collectionviewForCredits.dataSource = self
            collectionviewForCredits.delegate = self
            collectionviewForCredits.register(MovieCastCell.self, forCellWithReuseIdentifier: "MovieCastCell")
            collectionviewForCredits.showsHorizontalScrollIndicator = false
            collectionviewForCredits.showsVerticalScrollIndicator = false
            collectionviewForCredits.alwaysBounceVertical = false
            collectionviewForCredits.backgroundColor = .clear
            collectionviewForCredits.tag = 103
            self.view.addSubview(collectionviewForCredits)
            collectionviewForCredits.translatesAutoresizingMaskIntoConstraints = false
            collectionviewForCredits.topAnchor.constraint(equalTo: movieCreditsTitle.bottomAnchor, constant: 30).isActive = true
            collectionviewForCredits.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            collectionviewForCredits.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            collectionviewForCredits.heightAnchor.constraint(equalToConstant: 220).isActive = true
            collectionviewForCredits.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50).isActive = true
        }
    }
    
    // MARK: MovieDetailViewDisplayLogic
    
    func displayMovieDetail(movieDetail: MovieDetailViewModel,
                            castMembers: CastMembersViewModel,
                            videoViewModel: VideoViewModel?) {
        
        self.movieDetailViewModel = movieDetail
        self.castMembersViewModel = castMembers
        self.videoViewModel = videoViewModel
        
        title = movieDetailViewModel?.title.stringValue
        labelAverageVote?.text = (movieDetailViewModel?.averageVote?.description).stringValue + " ✭"
        labelName?.text = self.movieDetailViewModel?.title
         
        labelOverview?.text = self.movieDetailViewModel?.overview
        labelOverview?.isUserInteractionEnabled = (labelOverview?.text?.count).intValue > 0
        
        if (videoViewModel?.results?.count).intValue > 0 {
            labelVideosTitle?.text = "Videos"
        } else {
            labelVideosTitle?.heightAnchor.constraint(equalToConstant: 0).isActive = true
            collectionviewForVideos?.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        
        if (castMembers.cast?.count).intValue > 0 {
            movieCreditsTitle?.text = "Cast Members"
        } else {
            movieCreditsTitle?.heightAnchor.constraint(equalToConstant: 0).isActive = true
            collectionviewForCredits?.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        
        if let imageUrl = movieDetailViewModel?.imageUrl {
            DispatchQueue.main.async { [weak self] in
                let url = Constants.imagePrefixURL +  imageUrl
                self?.imageView?.sd_setImage(with: URL(string: url),
                                           placeholderImage: UIImage(named: "movie"))
            }
        }
        else {
            imageView?.contentMode = .scaleAspectFill
            imageView?.image = UIImage(named: "movie")
        }
        
        collectionviewForVideos?.reloadData()
        collectionviewForCredits?.reloadData()
    }
    
    // MARK: Action
    
    @objc func homeButtonAction(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func overViewAction(sender: UIBarButtonItem) {
        
        if let name = movieDetailViewModel?.title, let overview = movieDetailViewModel?.overview {
            router?.routeToOverviewPage(overview: overview, movieName: name)
        }
    }
}
