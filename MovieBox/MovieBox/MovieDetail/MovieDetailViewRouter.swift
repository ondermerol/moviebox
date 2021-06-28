//
//  MovieDetailViewRouter.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit

@objc protocol MovieDetailViewRoutingLogic {
    func routeToPersonDetail(personId: Int)
    func routeToOverviewPage(overview: String, movieName: String)
}

protocol MovieDetailViewDataPassing {
    var dataStore: MovieDetailViewDataStore? { get set }
}

class MovieDetailViewRouter: NSObject, MovieDetailViewRoutingLogic, MovieDetailViewDataPassing {
    
    weak var viewController: MovieDetailViewController?
    var dataStore: MovieDetailViewDataStore?
  
    // MARK: Routing
  
    func routeToPersonDetail(personId: Int) {
        let destinationVC = PersonDetailViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToPersonDetailPage(personId, destination: &destinationDS)
        navigateToPage(destinationVC: destinationVC)
    }
    
    func routeToOverviewPage(overview: String, movieName: String) {
        let destinationVC = BiographyViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToOverviewPage(overview, movieName, destination: &destinationDS)
        navigateToOverviewPage(destinationVC: destinationVC)
    }

    // MARK: Navigation
  
    private func navigateToPage(destinationVC: BaseViewControlller) {
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    private func navigateToOverviewPage(destinationVC: BaseViewControlller) {
        viewController?.navigationController?.present(destinationVC, animated: true, completion: nil)
    }
  
    // MARK: Passing data
  
    private func passDataToPersonDetailPage(_ personId: Int, destination: inout PersonDetailViewDataStore) {
        destination.personId = personId
    }
    
    private func passDataToOverviewPage(_ overview: String, _ movieName: String, destination: inout BiographyViewDataStore) {
        destination.biographyText = overview
        destination.name = movieName
    }
}
