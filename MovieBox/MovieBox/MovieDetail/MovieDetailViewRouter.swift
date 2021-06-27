//
//  MovieDetailViewRouter.swift
//  MovieBox
//
//  Created by Wolverin Mm on 27.06.2021.
//

import UIKit

@objc protocol MovieDetailViewRoutingLogic {
  
}

protocol MovieDetailViewDataPassing {
    var dataStore: MovieDetailViewDataStore? { get }
}

class MovieDetailViewRouter: NSObject, MovieDetailViewRoutingLogic, MovieDetailViewDataPassing {
    weak var viewController: MovieDetailViewController?
    var dataStore: MovieDetailViewDataStore?
  
    // MARK: Routing
  

    // MARK: Navigation
  
  
    // MARK: Passing data
  
}
