//
//  PersonDetailViewController.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit

protocol PersonDetailViewDisplayLogic: class {
    func displayPersonDetail(personDetail: PersonDetailViewModel, movieCredit: PersonMovieCreditViewModel)
}

class PersonDetailViewController: BaseViewControlller, PersonDetailViewDisplayLogic, UIScrollViewDelegate {

    // MARK: Properties
    
    var interactor: PersonDetailViewBusinessLogic?
    var router: (NSObject & PersonDetailViewRoutingLogic & PersonDetailViewDataPassing)?
    
    var personDetailViewModel: PersonDetailViewModel?
    var movieCreditViewModel: PersonMovieCreditViewModel?
    
    var scrollView: UIScrollView?
    var labelName: UILabel?
    var labelDepartmant: UILabel?
    var labelBiography: UILabel?
    var labelMovieCreditsTitle: UILabel?
    
    var collectionView: UICollectionView?
    var imageView: UIImageView?
    
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
        
        if let id = router?.dataStore?.personId {
            interactor?.getPersonDetail(forPersonId: id)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
  
    // MARK: Setup
  
    private func setup() {
        let viewController = self
        let interactor = PersonDetailViewInteractor()
        let presenter = PersonDetailViewPresenter()
        let router = PersonDetailViewRouter()
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
        
        // Known For Department
        
        labelDepartmant = UILabel()
        
        guard let labelDepartmant = labelDepartmant else {
            return
        }
        
        labelDepartmant.font = FontUtility.descriptionFont()
        labelDepartmant.textColor = ColorUtility.decriptionColor()
        labelDepartmant.numberOfLines = 0
        
        contentView.addSubview(labelDepartmant)
        
        labelDepartmant.translatesAutoresizingMaskIntoConstraints = false
        labelDepartmant.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 2).isActive = true
        labelDepartmant.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        labelDepartmant.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10).isActive = true
        labelDepartmant.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
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
        imageView.topAnchor.constraint(equalTo: labelDepartmant.bottomAnchor, constant: 20).isActive = true
        
        // Biography
        
        labelBiography = UILabel()
        
        guard let labelBiography = labelBiography else {
            return
        }
        
        labelBiography.font = FontUtility.descriptionFont()
        labelBiography.textColor = ColorUtility.decriptionColor()
        labelBiography.numberOfLines = 0
        
        contentView.addSubview(labelBiography)
        
        labelBiography.translatesAutoresizingMaskIntoConstraints = false
        labelBiography.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        labelBiography.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20).isActive = true
        labelBiography.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        labelBiography.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(biographyAction))
        labelBiography.isUserInteractionEnabled = true
        labelBiography.addGestureRecognizer(tap)
        
        // Movie Credits Title
        
        labelMovieCreditsTitle = UILabel()
        
        guard let labelMovieCreditsTitle = labelMovieCreditsTitle else {
            return
        }
        
        labelMovieCreditsTitle.font = FontUtility.titleFont()
        labelMovieCreditsTitle.textColor = ColorUtility.titleColor()
        labelMovieCreditsTitle.numberOfLines = 0
        
        contentView.addSubview(labelMovieCreditsTitle)
        
        labelMovieCreditsTitle.translatesAutoresizingMaskIntoConstraints = false
        labelMovieCreditsTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40).isActive = true
        labelMovieCreditsTitle.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        labelMovieCreditsTitle.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10).isActive = true
        labelMovieCreditsTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // collectionView
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 150, height: 220)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PersonCastCell.self, forCellWithReuseIdentifier: "PersonCastCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = false
        collectionView.backgroundColor = .clear
        collectionView.tag = 100
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: labelMovieCreditsTitle.bottomAnchor, constant: 30).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50).isActive = true
    }
    
    // MARK: PersonDetailViewDisplayLogic
    
    func displayPersonDetail(personDetail: PersonDetailViewModel, movieCredit: PersonMovieCreditViewModel) {
        personDetailViewModel = personDetail
        movieCreditViewModel = movieCredit
        
        title = personDetailViewModel?.name.stringValue
        
        labelName?.text = self.personDetailViewModel?.name
        labelDepartmant?.text = self.personDetailViewModel?.knownForDepartment
        
        labelBiography?.text = self.personDetailViewModel?.biography
        labelBiography?.isUserInteractionEnabled = (labelBiography?.text?.count).intValue > 0
        
        if (movieCreditViewModel?.cast?.count).intValue > 0 {
            labelMovieCreditsTitle?.text = "Movie Credits"
        } else {
            labelMovieCreditsTitle?.heightAnchor.constraint(equalToConstant: 0).isActive = true
            collectionView?.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        
        if let imageUrl = personDetailViewModel?.imageUrl {
            DispatchQueue.main.async { [weak self] in
                let url = Constants.imagePrefixURL +  imageUrl
                self?.imageView?.sd_setImage(with: URL(string: url),
                                             placeholderImage: UIImage(named: "avatar"))
            }
        } else {
            imageView?.contentMode = .scaleAspectFill
            imageView?.image = UIImage(named: "avatar")
        }
        
        collectionView?.reloadData()
    }
    
    // MARK: Action
    
    @objc func homeButtonAction(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func biographyAction(sender: UIBarButtonItem) {
        
        if let name = personDetailViewModel?.name, let biography = personDetailViewModel?.biography {
            router?.routeToBiographyDetail(biography: biography, actorName: name)
        }
    }
}
