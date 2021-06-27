//
//  MovieDetailViewInteractor.swift
//  MovieBox
//
//  Created by Wolverin Mm on 27.06.2021.
//

import UIKit

protocol MovieDetailViewBusinessLogic {
    
}

protocol MovieDetailViewDataStore {
    var movieId: Int? { get set }
}

class MovieDetailViewInteractor: MovieDetailViewBusinessLogic, MovieDetailViewDataStore {
    
    var presenter: MovieDetailViewPresentationLogic?
    var worker: MovieDetailViewWorker? = MovieDetailViewWorker()
    var movieId: Int?
}
