//
//  DashboardViewRouter.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 26.06.2021.
//

import UIKit

@objc protocol DashboardViewRoutingLogic {
    func routeToMovieDetail(movieId: Int)
    func routeToPersonDetail(personId: Int)
}

protocol DashboardViewDataPassing {
    var dataStore: DashboardViewDataStore? { get }
}

class DashboardViewRouter: NSObject, DashboardViewRoutingLogic, DashboardViewDataPassing {
    
    weak var viewController: DashboardViewController?
    var dataStore: DashboardViewDataStore?
  
    // MARK: Routing
  
    func routeToMovieDetail(movieId: Int) {
        let destinationVC = MovieDetailViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToMovieDetailPage(movieId, destination: &destinationDS)
        navigateToPage(destinationVC: destinationVC)
    }
    
    func routeToPersonDetail(personId: Int) {
        let destinationVC = PersonDetailViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToPersonDetailPage(personId, destination: &destinationDS)
        navigateToPage(destinationVC: destinationVC)
    }

    // MARK: Navigation
    
    private func navigateToPage(destinationVC: BaseViewControlller) {
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
  
    // MARK: Passing data
  
    private func passDataToMovieDetailPage(_ movieId: Int, destination: inout MovieDetailViewDataStore) {
        destination.movieId = movieId
    }
    
    private func passDataToPersonDetailPage(_ personId: Int, destination: inout PersonDetailViewDataStore) {
        destination.personId = personId
    }
}
