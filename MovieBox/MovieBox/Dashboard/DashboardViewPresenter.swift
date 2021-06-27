//
//  DashboardViewPresenter.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit

protocol DashboardViewPresentationLogic {
    func presentPopularMovies(movieListViewModel: MovieListViewModel)
    func presentBothSearchedPeopleAndMovie(movieListViewModel: MovieListViewModel,
                                           peopleListViewModel: PeopleListViewModel)
}

class DashboardViewPresenter: DashboardViewPresentationLogic {
    
    weak var viewController: DashboardViewDisplayLogic?
  
    func presentPopularMovies(movieListViewModel: MovieListViewModel) {
        viewController?.displayPopularMovies(movieListViewModel: movieListViewModel)
    }
    
    func presentBothSearchedPeopleAndMovie(movieListViewModel: MovieListViewModel,
                                           peopleListViewModel: PeopleListViewModel) {
        viewController?.displayBothSearchedPeopleAndMovie(movieListViewModel: movieListViewModel,
                                                          peopleListViewModel: peopleListViewModel)
    }
}
