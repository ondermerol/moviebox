//
//  PersonDetailRouter.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit

@objc protocol PersonDetailViewRoutingLogic {
    func routeToMovieDetail(movieId: Int)
    func routeToBiographyDetail(biography: String, actorName: String)
}

protocol PersonDetailViewDataPassing {
    var dataStore: PersonDetailViewDataStore? { get }
}

class PersonDetailViewRouter: NSObject, PersonDetailViewRoutingLogic, PersonDetailViewDataPassing {
    
    weak var viewController: PersonDetailViewController?
    var dataStore: PersonDetailViewDataStore?
  
    // MARK: Routing
  
    func routeToMovieDetail(movieId: Int) {
        let destinationVC = MovieDetailViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToMovieDetailPage(movieId, destination: &destinationDS)
        navigateToPage(destinationVC: destinationVC)
    }
    
    func routeToBiographyDetail(biography: String, actorName: String) {
        let destinationVC = BiographyViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToBiographyPage(biography, actorName, destination: &destinationDS)
        navigateToBiographyPage(destinationVC: destinationVC)
    }
    
    // MARK: Navigation
  
    private func navigateToPage(destinationVC: BaseViewControlller) {
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    private func navigateToBiographyPage(destinationVC: BaseViewControlller) {
        viewController?.navigationController?.present(destinationVC, animated: true, completion: nil)
    }
  
    // MARK: Passing data
  
    private func passDataToMovieDetailPage(_ movieId: Int, destination: inout MovieDetailViewDataStore) {
        destination.movieId = movieId
    }
    
    private func passDataToBiographyPage(_ biography: String, _ actorName: String, destination: inout BiographyViewDataStore) {
        destination.biographyText = biography
        destination.name = actorName
    }
}
