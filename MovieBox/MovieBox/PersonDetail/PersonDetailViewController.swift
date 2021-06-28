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
        
        let labelName = UILabel()
        labelName.font = FontUtility.titleFont()
        labelName.textColor = ColorUtility.titleColor()
        labelName.numberOfLines = 0
        labelName.text = self.personDetailViewModel?.name
        
        contentView.addSubview(labelName)
        
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        labelName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        labelName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        labelName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // Known For Department
        
        let labelDepartmant = UILabel()
        labelDepartmant.font = FontUtility.descriptionFont()
        labelDepartmant.textColor = ColorUtility.decriptionColor()
        labelDepartmant.numberOfLines = 0
        labelDepartmant.text = self.personDetailViewModel?.knownForDepartment
        
        contentView.addSubview(labelDepartmant)
        
        labelDepartmant.translatesAutoresizingMaskIntoConstraints = false
        labelDepartmant.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 2).isActive = true
        labelDepartmant.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        labelDepartmant.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10).isActive = true
        labelDepartmant.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
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
        imageView.topAnchor.constraint(equalTo: labelDepartmant.bottomAnchor, constant: 20).isActive = true
        
        DispatchQueue.main.async {
            let url = "https://image.tmdb.org/t/p/w500" +  (self.personDetailViewModel?.imageUrl).stringValue
            imageView.sd_setImage(with: URL(string: url),
                                       placeholderImage: UIImage(named: "avatar"))
        }
        
        // Biography
        
        let labelBiography = UILabel()
        labelBiography.font = FontUtility.descriptionFont()
        labelBiography.textColor = ColorUtility.decriptionColor()
        labelBiography.numberOfLines = 0
        labelBiography.text = self.personDetailViewModel?.biography
        
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
        
        let movieCreditsLabel = UILabel()
        movieCreditsLabel.font = FontUtility.titleFont()
        movieCreditsLabel.textColor = ColorUtility.titleColor()
        movieCreditsLabel.numberOfLines = 0
        movieCreditsLabel.text = "Movie Credits"
        
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
        collectionview.register(PersonCastCell.self, forCellWithReuseIdentifier: "PersonCastCell")
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
    
    // MARK: PersonDetailViewDisplayLogic
    
    func displayPersonDetail(personDetail: PersonDetailViewModel, movieCredit: PersonMovieCreditViewModel) {
        personDetailViewModel = personDetail
        movieCreditViewModel = movieCredit
        
        title = personDetailViewModel?.name.stringValue
        
        setupView()
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
