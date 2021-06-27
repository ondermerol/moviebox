//
//  PersonDetailPresenter.swift
//  MovieBox
//
//  Created by Wolverin Mm on 27.06.2021.
//

import Foundation
import UIKit

protocol PersonDetailViewPresentationLogic {
    func presentPersonDetail(personDetail: PersonDetailViewModel, movieCredit: PersonMovieCreditViewModel)
}

class PersonDetailViewPresenter: PersonDetailViewPresentationLogic {
    
    weak var viewController: PersonDetailViewDisplayLogic?
  
    func presentPersonDetail(personDetail: PersonDetailViewModel, movieCredit: PersonMovieCreditViewModel) {
        viewController?.displayPersonDetail(personDetail: personDetail, movieCredit: movieCredit)
    }
}
