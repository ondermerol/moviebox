//
//  MovieDetailViewInteractor.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit

protocol MovieDetailViewBusinessLogic {
    func getMoviewDetail(forMoviewId id: Int)
}

protocol MovieDetailViewDataStore {
    var movieId: Int? { get set }
}

class MovieDetailViewInteractor: MovieDetailViewBusinessLogic, MovieDetailViewDataStore {
    
    var presenter: MovieDetailViewPresentationLogic?
    var worker: MovieDetailViewWorker? = MovieDetailViewWorker()
    var movieId: Int?
    
    func getMoviewDetail(forMoviewId id: Int) {
        
        LoadingViewUtility.showLoadingView()
        
        worker?.getMovieDetail(withMovieId: id, completionHandler: { (movieDetail, error) in
            
            if let movieDetail = movieDetail, error == nil  {
                
                self.worker?.getMovieCastMembers(withMovieId: id, completionHandler: { (castMembers, error) in
                    
                    if let castMembers = castMembers, error == nil  {
                        
                        self.worker?.getMovieVideos(withMovieId: id, completionHandler: { (videoViewModel, error) in
                            
                            LoadingViewUtility.hideLoadingView()
                            self.presenter?.presentMovieDetail(movieDetail: movieDetail,
                                                               castMembers: castMembers,
                                                               videoViewModel: videoViewModel)
                        })
                        
                    } else {
                        LoadingViewUtility.hideLoadingView()
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
