//
//  PersonDetailViewInteractor.swift
//  MovieBox
//
//  Created by Önder Murat Erol on 27.06.2021.
//

import UIKit

protocol PersonDetailViewBusinessLogic {
    func getPersonDetail(forPersonId id: Int)
}

protocol PersonDetailViewDataStore {
    var personId: Int? { get set }
}

class PersonDetailViewInteractor: PersonDetailViewBusinessLogic, PersonDetailViewDataStore {
    
    var presenter: PersonDetailViewPresentationLogic?
    var worker: PersonDetailViewWorker? = PersonDetailViewWorker()
    var personId: Int?
    
    func getPersonDetail(forPersonId id: Int) {
        
        LoadingViewUtility.showLoadingView()
        
        worker?.getPersonDetail(withPersonId: id, completionHandler: { (personDetail, error) in
            
            if let personDetail = personDetail, error == nil  {
                
                self.worker?.getPersonMovieCredits(withPersonId: id, completionHandler: { (personMovieCredit, error) in
                    
                    LoadingViewUtility.hideLoadingView()
                    
                    if let personMovieCredit = personMovieCredit, error == nil  {
                        self.presenter?.presentPersonDetail(personDetail: personDetail, movieCredit: personMovieCredit)
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
