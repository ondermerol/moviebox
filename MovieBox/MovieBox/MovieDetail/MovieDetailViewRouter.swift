//
//  MovieDetailViewRouter.swift
//  MovieBox
//
//  Created by Wolverin Mm on 27.06.2021.
//

import UIKit

@objc protocol MovieDetailViewRoutingLogic {
    func routeToPersonDetail(personId: Int)
}

protocol MovieDetailViewDataPassing {
    var dataStore: MovieDetailViewDataStore? { get }
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

    // MARK: Navigation
  
    private func navigateToPage(destinationVC: BaseViewControlller) {
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
  
    // MARK: Passing data
  
    private func passDataToPersonDetailPage(_ personId: Int, destination: inout PersonDetailViewDataStore) {
        destination.personId = personId
    }
}
