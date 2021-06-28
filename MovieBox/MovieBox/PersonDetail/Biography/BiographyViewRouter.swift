//
//  BiographyViewRouter.swift
//  MovieBox
//
//  Created by Wolverin Mm on 27.06.2021.
//

import UIKit

@objc protocol BiographyViewRoutingLogic {
    func routeBack()
}

protocol BiographyViewDataPassing {
    var dataStore: BiographyViewDataStore? { get set }
}

class BiographyViewRouter: NSObject, BiographyViewRoutingLogic, BiographyViewDataPassing {

    weak var viewController: BiographyViewController?
    var dataStore: BiographyViewDataStore?
  
    // MARK: Routing
  
    func routeBack() {
        navigateBack()
    }
    
    // MARK: Navigation
  
    private func navigateBack() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
