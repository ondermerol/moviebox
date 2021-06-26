//
//  DashboardViewInteractor.swift
//  MovieBox
//
//  Created by Onder on 25.06.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SCLAlertView

protocol DashboardViewBusinessLogic {
    func getPopularMovies(forpage page:Int)
}

protocol DashboardViewDataStore {
    
}

class DashboardViewInteractor: DashboardViewBusinessLogic, DashboardViewDataStore {
    var presenter: DashboardViewPresentationLogic?
    var worker: DashboardViewWorker? = DashboardViewWorker()
  
    func getPopularMovies(forpage page:Int) {
        
        worker?.getPopularMovies(forpage: page, completionHandler: { (movieList, error) in
            
            if let movieList = movieList, error == nil  {
                self.presenter?.presentPopularMovies(movieListViewModel: movieList)
            } else {
                DialogBoxUtility.showError(message: Constants.errorMessage)
            }
        })
    }
}
