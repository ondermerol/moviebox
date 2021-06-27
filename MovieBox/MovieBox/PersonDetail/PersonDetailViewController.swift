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

class PersonDetailViewController: BaseViewControlller, PersonDetailViewDisplayLogic {

    // MARK: Properties
    
    var interactor: PersonDetailViewBusinessLogic?
    var router: (NSObjectProtocol & PersonDetailViewRoutingLogic & PersonDetailViewDataPassing)?
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
        
        var contentSizeHeight: CGFloat = 0
        
        guard let scrollView = scrollView else {
            return
        }
        
        scrollView.backgroundColor = ColorUtility.appViewColor()
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: getTotalTopBarHeight()).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentSizeHeight = contentSizeHeight + getTotalTopBarHeight()
        
        // Name
        
        let labelName = UILabel()
        labelName.font = FontUtility.titleFont()
        labelName.textColor = ColorUtility.titleColor()
        labelName.numberOfLines = 0
        labelName.text = self.personDetailViewModel?.name
        
        scrollView.addSubview(labelName)
        
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        labelName.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        labelName.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10).isActive = true
        labelName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        contentSizeHeight = contentSizeHeight + 40 + 20
        
        // Known For Department
        
        let labelDepartmant = UILabel()
        labelDepartmant.font = FontUtility.descriptionFont()
        labelDepartmant.textColor = ColorUtility.decriptionColor()
        labelDepartmant.numberOfLines = 0
        labelDepartmant.text = self.personDetailViewModel?.knownForDepartment
        
        scrollView.addSubview(labelDepartmant)
        
        labelDepartmant.translatesAutoresizingMaskIntoConstraints = false
        labelDepartmant.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 2).isActive = true
        labelDepartmant.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        labelDepartmant.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10).isActive = true
        labelDepartmant.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        contentSizeHeight = contentSizeHeight + 25 + 2
        
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
        imageView.topAnchor.constraint(equalTo: labelDepartmant.bottomAnchor, constant: 20).isActive = true
        
        DispatchQueue.main.async {
            let url = "https://image.tmdb.org/t/p/w500" +  (self.personDetailViewModel?.imageUrl).stringValue
            imageView.sd_setImage(with: URL(string: url),
                                       placeholderImage: UIImage(named: "avatar"))
        }
        
        contentSizeHeight = contentSizeHeight + 200 + 20
        
        // Biography
        
        let labelBiography = UILabel()
        labelBiography.font = FontUtility.descriptionFont()
        labelBiography.textColor = ColorUtility.decriptionColor()
        labelBiography.numberOfLines = 0
        labelBiography.text = self.personDetailViewModel?.biography
        
        scrollView.addSubview(labelBiography)
        
        labelBiography.translatesAutoresizingMaskIntoConstraints = false
        labelBiography.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        labelBiography.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20).isActive = true
        labelBiography.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        labelBiography.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(biographyAction))
        labelBiography.isUserInteractionEnabled = true
        labelBiography.addGestureRecognizer(tap)
        
        // Collectionview
        
        var collectionview: UICollectionView!
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 150, height: 300)
        collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(PersonCastCell.self, forCellWithReuseIdentifier: "PersonCastCell")
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
