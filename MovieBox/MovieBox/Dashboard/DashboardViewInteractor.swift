//
//  DashboardViewInteractor.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit
import SCLAlertView

protocol DashboardViewBusinessLogic {
    func getPopularMovies(forpage page: Int)
    func searchBothMoviesAndPeople(forMoviePage moviePage: Int, forPeoplePage peoplePage: Int, queryString: String?)
}

protocol DashboardViewDataStore {
    
}

class DashboardViewInteractor: DashboardViewBusinessLogic, DashboardViewDataStore {
    
    var presenter: DashboardViewPresentationLogic?
    var worker: DashboardViewWorker? = DashboardViewWorker()
  
    func getPopularMovies(forpage page:Int) {
        
        LoadingViewUtility.showLoadingView()
        
        worker?.getPopularMovies(forpage: page, completionHandler: { (movieList, error) in
            
            if let movieList = movieList, error == nil  {
                self.worker?.getGenres(completionHandler: { (genreList, error) in
                    LoadingViewUtility.hideLoadingView()
                    self.presenter?.presentPopularMovies(movieListViewModel: movieList, genreViewModel: genreList)
                })
            } else {
                LoadingViewUtility.hideLoadingView()
                DialogBoxUtility.showError(message: Constants.errorMessage)
            }
        })
    }
    
    func searchBothMoviesAndPeople(forMoviePage moviePage: Int, forPeoplePage peoplePage: Int, queryString: String?) {
        
        LoadingViewUtility.showLoadingView()
        
        worker?.searchMovies(forpage: moviePage, queryString: queryString, completionHandler: { (movieList, error) in
            
            if let movieList = movieList, error == nil  {
                self.worker?.searchPeople(forpage: peoplePage, queryString: queryString, completionHandler: { (peopleList, error) in
                    
                    LoadingViewUtility.hideLoadingView()
                    
                    if let peopleList = peopleList, error == nil  {
                        self.presenter?.presentBothSearchedPeopleAndMovie(movieListViewModel: movieList,
                                                                          peopleListViewModel: peopleList)
                    } else {
                        DialogBoxUtility.showError(message: Constants.errorMessage)
                    }
                })
            } else {
                LoadingViewUtility.hideLoadingView()
                DialogBoxUtility.showError(message: Constants.errorMessage)
            }
        })
    }
}
