//
//  MovieDetailViewPresenter.swift
//  MovieBox
//
//  Created by Wolverin Mm on 27.06.2021.
//

import UIKit

protocol MovieDetailViewPresentationLogic {
    func presentMovieDetail(movieDetail: MovieDetailViewModel, castMembers: CastMembersViewModel)
}

class MovieDetailViewPresenter: MovieDetailViewPresentationLogic {
    
    weak var viewController: MovieDetailViewDisplayLogic?
    
    func presentMovieDetail(movieDetail: MovieDetailViewModel, castMembers: CastMembersViewModel) {
        viewController?.displayMovieDetail(movieDetail: movieDetail, castMembers: castMembers)
    }
}
