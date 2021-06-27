//
//  MovieDetailViewController.swift
//  MovieBox
//
//  Created by Wolverin Mm on 27.06.2021.
//

import UIKit

protocol MovieDetailViewDisplayLogic: class {
    
}

class MovieDetailViewController: BaseViewControlller, MovieDetailViewDisplayLogic {

    // MARK: Properties
    
    var interactor: MovieDetailViewBusinessLogic?
    var router: (NSObjectProtocol & MovieDetailViewRoutingLogic & MovieDetailViewDataPassing)?
    
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
}
