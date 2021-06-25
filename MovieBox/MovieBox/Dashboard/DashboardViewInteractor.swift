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
import Alamofire

protocol DashboardViewBusinessLogic {
    func getMovies()
}

protocol DashboardViewDataStore {
    
}

class DashboardViewInteractor: DashboardViewBusinessLogic, DashboardViewDataStore {
    var presenter: DashboardViewPresentationLogic?
    var worker: DashboardViewWorker?
  
  // MARK: Do something
  
    func getMovies() {
        let request = AF.request("https://api.themoviedb.org/3/movie/popular/?api_key=8c42cdf8179116388dd8fb6ca5a7046d&page=1")
            // 2
        request.responseJSON { (data) in
              print(data)
        }
    }
}
